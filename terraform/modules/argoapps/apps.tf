
variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "cluster_name" {
  description = "name of the cluster"
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file for the GKE cluster"
}

variable "argocd_endpoint" {
  description = "ArgoCD endppoint to ensure it is up and running"
}

# App to deploy

data "google_client_config" "provider" {}

data "google_container_cluster" "cluster" {
  depends_on = [var.kubeconfig_path]
  name       = var.cluster_name
  location   = var.region
  project    = var.project_id
}

provider "kubernetes" {

  host = "https://${data.google_container_cluster.cluster.endpoint}"

  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

# List your ArgoCD apps to deploy

resource "kubernetes_manifest" "application_xyz_liatrio_demo" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "Application"
    "metadata" = {
      "annotations" = {
        "argocd-image-updater.argoproj.io/image-list" = "liatrio=us-central1-docker.pkg.dev/test-project-miguel/xyz-liatrio-poc/xyz-liatrio:dev"
        "argocd-image-updater.argoproj.io/liatrio.force-update" = "true"
        "argocd-image-updater.argoproj.io/liatrio.update-strategy" = "digest"
      }
      "name" = "xyz-liatrio-demo"
      "namespace" = "argocd"
    }
    "spec" = {
      "destination" = {
        "name" = ""
        "namespace" = "default"
        "server" = "https://kubernetes.default.svc"
      }
      "project" = "default"
      "source" = {
        "path" = "charts/xyz-liatrio"
        "repoURL" = "https://github.com/miguelortize/liatrio-xyz-poc"
        "targetRevision" = "HEAD"
      }
      "sources" = []
      "syncPolicy" = {
        "automated" = {
          "prune" = false
          "selfHeal" = false
        }
      }
    }
  }
}
