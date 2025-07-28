resource "aws_s3_bucket" "mlflow_artifacts" {
  bucket = var.s3_bucket_name

  tags = var.terraform_tags
}
