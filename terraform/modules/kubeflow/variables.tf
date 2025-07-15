variable "eks_cluster_name" {
  type        = string
}
variable "local_helm_repo" {
  description = "Local Helm charts path"
  type        = string
}
variable "static_email" {
  type = string
}
variable "kubeflow_user_profile" {
  type = string
}
variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}
variable "user_profile_role_arn" {
  description = "The ARN of the IAM role for the Kubeflow User Profile service account."
  type        = string
}
variable "region" {
  description = "AWS region."
  type        = string
}
variable "profile_controller_role_arn" {
  type = string
}
