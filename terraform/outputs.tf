# outputs.tf
output "frontend_url" {
  description = "URL of the frontend application"
  value       = "http://${aws_lb.frontend.dns_name}"
}

output "backend_url" {
  description = "URL of the backend application"
  value       = "http://${aws_lb.backend.dns_name}"
}