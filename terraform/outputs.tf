output "kubernetes_cluster_name" {
  value       = module.deploy_xyz_infrastructure.kubernetes_cluster_name
  description = "Description of the kubernetes cluster created."
}

output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_host" {
  value       = module.deploy_xyz_infrastructure.kubernetes_cluster_host
  description = "GKE Cluster Host"
}

output "app_load_balancer_endpoint" {
  value       = "http://${module.deploy_xyz_bootstrap.app_load_balancer_endpoint}:80"
  description = "Load Balancer for app deployed."
}