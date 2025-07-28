locals {
  oidc_provider_url = replace(data.aws_iam_openid_connect_provider.eks.url, "https://", "")
}
