output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}
output "eks_cluster_node_id" {
  value = aws_eks_node_group.general.id
}
output "profiles_controller_role_arn" {
  value = module.profiles_controller_irsa.iam_role_arn
}
output "user_profile_role_arn" {
  value = aws_iam_role.user_profile_role.arn
}
