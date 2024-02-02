
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

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.cluster.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.provider.access_token
  }
}

provider "kubernetes" {

  host = "https://${data.google_container_cluster.cluster.endpoint}"

  token                  = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

# List your ArgoCD apps to deploy

resource "helm_release" "argocd_apps" {
  depends_on = [var.argocd_endpoint]
  name       = "argocd-apps"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"
  chart      = "argocd-apps"

  values = [
    file("${path.module}/apps/values.yaml")
  ]

}

resource "time_sleep" "wait_60_seconds" {
  depends_on = [helm_release.argocd_apps]

  create_duration = "60s"
}

data "kubernetes_service" "argocd_apps" {
  depends_on = [time_sleep.wait_60_seconds]
  metadata {
    name      = "xyz-liatrio-demo"
    namespace = "default"
  }
}