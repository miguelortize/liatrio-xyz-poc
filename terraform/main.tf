# This codebase will create the infrastructure module and the app module.

module "deploy_xyz_infrastructure" {
  source       = "./modules/infrastructure"
  project_id   = var.project_id
  region       = var.region
  cluster_name = "${var.project_id}-gke"
}

module "deploy_xyz_bootstrap" {
  source          = "./modules/bootstrap"
  project_id      = var.project_id
  region          = var.region
  repository      = var.repository
  image_version   = var.image_version
  cluster_name    = module.deploy_xyz_infrastructure.kubernetes_cluster_name
  kubeconfig_path = module.deploy_xyz_infrastructure.kubeconfig_path
}


# provider "kubernetes" {
# #  load_config_file = "false"

#   host = "https://${data.google_container_cluster.cluster.endpoint}"
#   #   username = var.gke_username
#   #   password = var.gke_password

#   client_certificate     = google_container_cluster.primary.master_auth.0.client_certificate
#   client_key             = google_container_cluster.primary.master_auth.0.client_key
#   cluster_ca_certificate = base64decode(data.google_container_cluster.cluster.master_auth[0].cluster_ca_certificate)
# }