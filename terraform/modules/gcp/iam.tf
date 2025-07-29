resource "aws_iam_role_policy" "ecr_push_pull" {
  name = "ecr-push-pull"
  role = data.aws_iam_role.gha_role.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource : aws_ecr_repository.kubeflow_models.arn
      },
      {
        Effect : "Allow",
        Action : [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ],
        Resource : "*"
      }
    ]
  })
}
