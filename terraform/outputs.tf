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

output "argocd_load_balancer_endpoint" {
  value       = "http://${module.deploy_xyz_bootstrap.argocd_load_balancer_endpoint}:80"
  description = "Load Balancer for app deployed."
}

output "xyz_app_endpoint" {
  value       = "http://${module.deploy_xyz_apps.xyz_app_endpoint}:80"
  description = "Load Balancer for app deployed."
}

output "xyz_deployment_test" {
  value       = module.deploy_xyz_apps.xyz_deployment_test
  description = "Curl against app to test it works!."
}