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