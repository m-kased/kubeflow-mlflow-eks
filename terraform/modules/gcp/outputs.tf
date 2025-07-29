output "repository_url" {
  description = "URI used by the GitHub workflow to push images"
  value       = aws_ecr_repository.kubeflow_models.repository_url
}
