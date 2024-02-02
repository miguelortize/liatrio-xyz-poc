
output "xyz_app_endpoint" {
  value       = data.kubernetes_service.argocd_apps.status.0.load_balancer.0.ingress.0.ip
  description = "Load Balancer for app deployed."
}

output "xyz_deployment_test" {
  value       = local.json_data
  description = "Test on Application"
}