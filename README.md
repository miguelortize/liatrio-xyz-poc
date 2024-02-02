# Liatrio XYZ Company PoC

## Google Resources Deployed:

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/GCP_infra.png)

## CI-CD Resources Deployed:

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/CI-CD-Architecture.png)

## Deployment strategy:

![](https://github.com/miguelortize/liatrio-xyz-poc/blob/main/img/terraform_liatrio.png)

## Prerequisite:
Before you can provision a GKE cluster using Terraform, you need to ensure that you have the following prerequisites in place:

- Google Cloud Platform (GCP) Account: GCP account with the necessary permissions to create and manage resources.
- Google Cloud SDK (gcloud) : which provides the command-line tools for interacting with GCP services.
- Enable Google Kubernetes Engine (GKE) API: Enable the GKE API for your project. You can enable it either through the Google Cloud Console or by running the following command with the gcloud CLI.
- Install Terraform and kubectl: Install [Terraform](https://terraform.io/downloads.html) and optionally [kubectl](https://kubernetes.io/docs/tasks/tools) on your local machine.
- Install [Google cloud SDK](https://formulae.brew.sh/cask/google-cloud-sdk)
- Clone Github Repo
```git clone https://github.com/miguelortize/liatrio-xyz-poc.git```

## Setup your GCP account and access.

```gcloud components install gke-gcloud-auth-plugin```

```gcloud init```

```gcloud auth application-default login```

```gcloud services enable container.googleapis.com --project=PROJECT_ID```


## Deploy your environment and app.

```cd terraform/```

```terraform init```

```terraform plan```

```terraform apply```

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
```

Open the url for `xyz_app_endpoint` in your chrome and test the response.

## Destroy your environment:

```terraform destroy```


### Optional to get the kubernetes login to your local:
```gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)```

### Optional to login to the Admin page of ArgoCD
```kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d```

Authentication and Credentials: Configure authentication for Terraform to access your GCP account. You can use either Application Default Credentials (ADC) or a Service Account key file

## Possible errors

You might encounter that the instance is trying to download a local helm chart, adjust this by running:

```
helm repo update
```