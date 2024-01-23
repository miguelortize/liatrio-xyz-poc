# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

data "google_client_config" "provider" {}

data "google_container_cluster" "cluster" {
  name     = google_container_cluster.primary.name
  location = var.region
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

  client_certificate     = google_container_cluster.primary.master_auth.0.client_certificate
  client_key             = google_container_cluster.primary.master_auth.0.client_key
  cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
}

# resource "helm_release" "nginx" {
#   name       = "nginx"
#   repository = "oci://registry-1.docker.io/bitnamicharts"
#   chart      = "nginx"

#   values = [
#     file("${path.module}/nginx-values.yaml")
#   ]
# }

# data "kubernetes_service" "nginx" {
#   depends_on = [helm_release.nginx]
#   metadata {
#     name = "nginx"
#   }
# }