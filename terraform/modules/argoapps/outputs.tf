
output "xyz_app_endpoint" {
  value = data.kubernetes_service.argocd_apps.status.0.load_balancer.0.ingress.0.ip
  #  value       = data.kubernetes_service.app
  description = "Load Balancer for app deployed."
}