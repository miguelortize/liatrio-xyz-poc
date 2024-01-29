
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

# resource "helm_release" "nginx" {
#   name       = "nginx"
#   repository = "oci://registry-1.docker.io/bitnamicharts"
#   chart      = "nginx"

#   values = [
#     file("${path.module}/nginx_values.yaml")
#   ]
# }

resource "helm_release" "app" {
  name  = "xyz-liatrio"
  chart = "${path.module}/charts/xyz-liatrio"

  #   values = [
  #     file("${path.module}/nginx_values.yaml")
  #   ]
}

data "kubernetes_service" "app" {
  depends_on = [helm_release.app]
  metadata {
    name = "xyz-liatrio"
  }
}