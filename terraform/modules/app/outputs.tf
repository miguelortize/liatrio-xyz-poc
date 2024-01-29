
output "app_load_balancer_endpoint" {
  value       = data.kubernetes_service.app.status.0.load_balancer.0.ingress.0.hostname
  description = "Load Balancer for app deployed."
}