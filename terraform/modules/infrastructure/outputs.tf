output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "kubeconfig_path" {
  description = "Path to the generated kubeconfig file"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}

# output "nginx_endpoint" {
#     value = "http://${data.kubernetes_service.nginx.status.0.load_balancer.0.ingress.0.hostname}"
# }