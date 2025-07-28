data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}

data "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "mlflow_s3_access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.mlflow_artifacts.arn,
      "${aws_s3_bucket.mlflow_artifacts.arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "mlflow_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_provider_url}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url}:sub"
      values   = ["system:serviceaccount:mlflow:mlflow"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_provider_url}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}
