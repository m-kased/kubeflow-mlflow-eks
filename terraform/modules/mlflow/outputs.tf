output "mlflow_namespace" {
  description = "The Kubernetes namespace where MLflow is deployed"
  value       = kubernetes_namespace.mlflow.metadata[0].name
}

output "artifact_bucket_name" {
  description = "S3 bucket name for MLflow artifacts"
  value       = aws_s3_bucket.mlflow_artifacts.bucket
}

output "mlflow_service_name" {
  description = "Name of the MLflow service"
  value       = "mlflow"
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for MLflow artifacts"
  value       = aws_s3_bucket.mlflow_artifacts.bucket
}
