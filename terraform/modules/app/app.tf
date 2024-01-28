
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
  name     = var.cluster_name
  location = var.region
  project = var.project_id
}

provider "helm" {
  kubernetes {
    host                   = "https://${data.google_container_cluster.cluster.endpoint}"
    cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.provider.access_token
  }
}


provider "kubernetes" {
  #  load_config_file = "false"

  host = "https://${data.google_container_cluster.cluster.endpoint}"
  #   username = var.gke_username
  #   password = var.gke_password

  client_certificate     = data.google_container_cluster.cluster.master_auth.0.client_certificate
  client_key             = data.google_container_cluster.cluster.master_auth.0.client_key
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "nginx"

  values = [
    file("${path.module}/nginx_values.yaml")
  ]
}

data "kubernetes_service" "nginx" {
  depends_on = [helm_release.nginx]
  metadata {
    name = "nginx"
  }
}