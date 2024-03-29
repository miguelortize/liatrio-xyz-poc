# Liatrio XYZ Company PoC

## Documentation
- [Setting up Workload Identity Federation for GitHub Actions](https://github.com/miguelortize/liatrio-xyz-poc/wiki/Create-Workload-Identity-Provider)

## Google Resources Deployed:

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/GCP_infra.png)

## Deployment strategy:

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/terraform_liatrio.png)

A platform engineer will create a PR where the cluster to be created is defined, the PR will trigger GHA (GH actions) that will run a test to ensure the change introduced is stable.

Upon Merge, GHA will tun a Terraform workflow that will deploy in the following structure:

- 1.a) GCP resources such as VPN and GKE cluster will be created and wait until the Kubernetes cluster is fully functional, this will return credentials for access that will be injected into the 'Bootstrap' module.

- 2.a) The bootstrap module will deploy ArgoCD and ArgoCD Image Updater and ensure these two are working as expected, it will also connect ArgoCD to the Github repository where the `helm charts`

- 2.b) The 'ArgoApps' module will be deployed as well which deploys the apps are defined and based on that will create the resources required on Kubernetes.

- 2.c) ArgoCD Image updater will connect to the Artifact Registry and pull the images based on the specified deployment strategy and method on the App annotations, this is how your continous deployment will know which version of the app to deploy.

- 3.a) Validation will be made with a curl command to the app to ensure that things are working as expected.

## CI workflow:

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/build-and-test-wf.png)

A developer will introduce a new change to the app.

Upon commit made on the `microservice` folder a github action will be triggered and this will first run Maven unit tests and build of the Java dependencies.

A /target folder will be created with the code .jar app to be deployed, this will be built and tagged by Docker and finally pushed into the Artifact Registry, our approach is based on image Digest, so everything will be tagged based on the environment defined at build time.

## CD workflow:

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/CI-CD-Architecture.png)

Case 1:
When a developer introduces a change on the code, a new digest of the image will be created and tagged based on environment, this will trigger Image Updater based on the [strategy](https://argocd-image-updater.readthedocs.io/en/stable/basics/update-strategies/#supported-update-strategies) defined on the annotations of the app CRD, which in our case is based on [digest](https://argocd-image-updater.readthedocs.io/en/stable/basics/update-strategies/#strategy-digest) and rollout will be managed by the deployment strategy.

Case 2:
When a platform engineer introduces a change on the /charts section, ArgoCD will look at the chart changes and attempt to replicate them, if anything fails, the `Sync` will show errors, if all goes as expected, it will automatically sync with the environment. You can [disable this feature](https://argo-cd.readthedocs.io/en/stable/user-guide/auto_sync/).

## Folder Structure

```
.
.github
└── workflows
│   ├── bearer.yaml
│   ├── build.yaml
│   └── terraform.yaml
│   # GHA to run automated build of cluster, code scanning, and terraform management.
├── CHANGELOG.md
├── README.md
├── charts
│   ├── xyz-liatrio
│   └── ...
│   # Charts to deploy our example app and other apps.
├── img
│   ├── CI-CD-Architecture.png
│   └── ...
│   # Images related to documentation 
├── microservice
│   └── app
│   # App logic, including Dockerfile, code testing, local testing instructions.
├── terraform
└── # Terraform logic to build GKE cluster and Bootstrap it with required charts and configurations.
    ├── backend.tf
    ├── main.tf
    ├── modules
    │   ├── argoapps
    │   │   ├── apps
    │   │   │   └── values.yaml
    │   │   │       # Onboard your Applications to deploy here!
    │   │   ├── apps.tf
    │   │   ├── outputs.tf
    │   │   ├── tests.tf
    │   │   └── versions.tf
    │   ├── bootstrap
    │   │   ├── bootstrap.tf
    │   │   ├── outputs.tf
    │   │   └── values
    │   │       └── image_updater.yaml
    │   │           # Add your chart values and configurations here!
    │   └── infrastructure
    │       ├── gke.tf
    │       ├── outputs.tf
    │       ├── versions.tf
    │       └── vpc.tf
    ├── outputs.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    ├── terraform.tfvars
    └── variables.tf
```


## Prerequisite:
In version v0.0.9 and prior, we were deploying resources from our local environment, from version v0.0.10 we start deploying from the Terraform Github Action, we will need to setup our Workflow Identity Federation to run cluster creation from GHA, please follow the [Setting up Workload Identity Federation for GitHub Actions](https://github.com/miguelortize/liatrio-xyz-poc/wiki/Create-Workload-Identity-Provider) to setup your Service Account and right permissions to deploy through code.

Before you can provision a GKE cluster using Terraform, you need to ensure that you have the following prerequisites in place:

- Clone Github Repo
```git clone https://github.com/miguelortize/liatrio-xyz-poc.git```
- Edit the .github/workflow/teraform.yaml workflow authentication auth steps so that you can setup your `project`, `provider`, and `service account`, if you don't have them yet, please create them following the "Prerequisites" section.

```
    # Configure Workload Identity Federation and generate an access token.
    - id: 'auth'
      name: 'Authenticate to Google Cloud'
      uses: 'google-github-actions/auth@v2'
      with:
        token_format: 'access_token'
        workload_identity_provider: 'projects/<PROJECT_ID>/locations/global/workloadIdentityPools/<WORKLOAD_IDENTITY_POOL>/providers/<PROVIDER>'
        service_account: '<SERVICE_ACCOUNT>@<PROJECT_NAME>.iam.gserviceaccount.com'
```

## Deploy your environment and app.

Currently, deployment of our environment is managed through [workflow_dispatch](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch), this is to facilitate the creation and destruction of resources, in the future, we will only create resources through merging PRs to main.

- Clone this repo.

```
git clone https://github.com/miguelortize/liatrio-xyz-poc.git
```

- Update the tfvars to match the project you created.

```
vi ./terraform/terraform.tfvars
# Update and save.

git checkout -b "create-my-cluster"

git commit -m "Create new cluster."

git push --set-upstream origin create-my-cluster
```

- Create a PR from your given branch to main, this will trigger a new github action and will automatically run a `terraform plan` for your resources, 

If all permissions are setup properly, it won't show any errors.

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/gha-output.png)

- Ask for assistance to merge your PR.

- The creation of the resources will take around 30 minutes, so we recomend you to prepare some cofee in the meantime and take a small break!

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/gha-apply-output.png)

### Terraform should return outputs that look something like this

```
# Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

 Outputs:

argocd_load_balancer_endpoint = "http://35.194.12.138:80"
kubernetes_cluster_host = "35.238.112.97"
kubernetes_cluster_name = "test-project-miguel-gke"
project_id = "test-project-miguel"
region = "us-central1"
xyz_app_endpoint = "http://34.122.98.168:80"
xyz_deployment_test = {
  "message" = "Automate all the things!"
  "timestamp" = 1706850034
}
```

Open the url for `xyz_app_endpoint` in your chrome and test the response.

## Destroy your environment:

- Return to the [Terraform workflow](https://github.com/miguelortize/liatrio-xyz-poc/actions/workflows/terraform.yaml) and run a `Terraform_destroy`

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/terraform_destroy.png)


### Optional to get the kubernetes login to your local:

```
# Use the value from your project_id for K8S_CLUSTER and add the suffix -gke
K8S_CLUSTER=test-project-miguel-gke
REGION=us-central1
PROJECT_NAME=test-project-miguel-gke

gcloud auth application-default login

gcloud services enable container.googleapis.com --project=${PROJECT_NAME}

gcloud container clusters get-credentials ${K8S_CLUSTER} --region ${REGION}
```

### Optional to login to the Admin page of ArgoCD
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Authentication and Credentials: Configure authentication for Terraform to access your GCP account. You can use either Application Default Credentials (ADC) or a Service Account key file

## Possible errors

It might be possible that due to slowness in the creation of the helm resources, the data source that provides the app service IP will fail, you might need to re run the apply once again if this happens.