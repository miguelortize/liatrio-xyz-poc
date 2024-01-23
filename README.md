# Liatrio XYZ Company PoC

Prerequisite:
Before you can provision a GKE cluster using Terraform, you need to ensure that you have the following prerequisites in place:

- Google Cloud Platform (GCP) Account: GCP account with the necessary permissions to create and manage resources.
- Google Cloud SDK (gcloud) : which provides the command-line tools for interacting with GCP services.
- Enable Google Kubernetes Engine (GKE) API: Enable the GKE API for your project. You can enable it either through the Google Cloud Console or by running the following command with the gcloud CLI.
- Install Terraform and kubectl: Install [Terraform](https://terraform.io/downloads.html) and optionally [kubectl](https://kubernetes.io/docs/tasks/tools) on your local machine.
- Install [Google cloud SDK](https://formulae.brew.sh/cask/google-cloud-sdk)

## Setup your GCP account and access.

```gcloud components install gke-gcloud-auth-plugin```
```gcloud init```
```gcloud auth application-default login```
```gcloud services enable container.googleapis.com --project=PROJECT_ID```
```git clone https://github.com/miguelortize/liatrio-xyz-poc.git```

## Deploy your environment and app.

```terraform init```

```terraform plan```

```terraform apply```

## Destroy your environment:

```terraform destroy```


### Optional to get the kubernetes login to your local:
```gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)```

Authentication and Credentials: Configure authentication for Terraform to access your GCP account. You can use either Application Default Credentials (ADC) or a Service Account key file