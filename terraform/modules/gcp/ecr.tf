resource "aws_ecr_repository" "kubeflow_models" {
  name = "kubeflow-models"

  lifecycle {
    prevent_destroy = true
  }

  tags = var.terraform_tags
}

resource "aws_ecr_lifecycle_policy" "cleanup" {
  repository = aws_ecr_repository.kubeflow_models.name

  policy = jsonencode({
    rules : [{
      rulePriority : 1,
      description : "Keep last 100 images",
      selection : {
        tagStatus : "any",
        countType : "imageCountMoreThan",
        countNumber : 100
      },
      action : { type : "expire" }
    }]
  })
}
