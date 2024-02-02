
data "curl" "test_application_endpoint" {
  depends_on  = [data.kubernetes_service.argocd_apps]
  http_method = "GET"
  uri         = "http://${data.kubernetes_service.argocd_apps.status.0.load_balancer.0.ingress.0.ip}:80"
}

locals {
  json_data = jsondecode(data.curl.test_application_endpoint.response)
}
