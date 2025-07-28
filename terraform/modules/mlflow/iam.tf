resource "aws_iam_policy" "mlflow_s3_access" {
  name        = "mlflow-s3-access-policy"
  description = "Policy granting MLflow access to S3 bucket for artifacts"
  policy      = data.aws_iam_policy_document.mlflow_s3_access.json

  tags = var.terraform_tags
}

resource "aws_iam_role" "mlflow_service_account" {
  name               = "mlflow-service-account-role"
  assume_role_policy = data.aws_iam_policy_document.mlflow_assume_role.json

  tags = var.terraform_tags
}

resource "aws_iam_role_policy_attachment" "mlflow_s3_access" {
  role       = aws_iam_role.mlflow_service_account.name
  policy_arn = aws_iam_policy.mlflow_s3_access.arn
}
