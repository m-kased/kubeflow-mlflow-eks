data "aws_eks_cluster" "eks" {
  name       = var.eks_cluster_name
  depends_on = [var.eks_cluster_name]
}

data "aws_eks_cluster_auth" "eks" {
  name       = var.eks_cluster_name
  depends_on = [var.eks_cluster_name]
}

data "aws_caller_identity" "current" {}
