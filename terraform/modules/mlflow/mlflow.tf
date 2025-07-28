resource "kubernetes_namespace" "mlflow" {
  metadata {
    name = "mlflow"
  }
}

resource "helm_release" "mlflow" {
  name       = "mlflow"
  repository = "https://community-charts.github.io/helm-charts"
  chart      = "mlflow"
  namespace  = kubernetes_namespace.mlflow.metadata[0].name

  values = [templatefile("${path.module}/templates/mlflow-values.yaml.tpl", {
    postgres_host            = aws_db_instance.mlflow_postgres.address
    postgres_port            = aws_db_instance.mlflow_postgres.port
    postgres_database        = aws_db_instance.mlflow_postgres.db_name
    postgres_user            = aws_db_instance.mlflow_postgres.username
    s3_bucket_name           = aws_s3_bucket.mlflow_artifacts.bucket
    service_account_role_arn = aws_iam_role.mlflow_service_account.arn
  })]

  # Set sensitive values
  set_sensitive {
    name  = "backendStore.postgres.password"
    value = aws_db_instance.mlflow_postgres.password
  }
}
