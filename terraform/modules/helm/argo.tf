resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "8.2.3"

  create_namespace = true
  namespace        = "argocd"

  values = ["./values/argo.yaml"]
}
