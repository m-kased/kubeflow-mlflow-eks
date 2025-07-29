resource "kubectl_manifest" "argocd" {
  yaml_body = templatefile("${path.module}/templates/gateway.yaml.tpl", {
    name      = "argocd"
    namespace = "argocd"
    domain    = var.domain
  })
}

resource "kubectl_manifest" "argocd" {
  yaml_body = templatefile("${path.module}/templates/virtualservice.yaml.tpl", {
    name      = "argocd"
    namespace = "argocd"
    domain    = var.domain
  })

  depends_on = [kubectl_manifest.argocd]
}

resource "kubectl_manifest" "argocd" {
  yaml_body = templatefile("${path.module}/templates/certificate.yaml.tpl", {
    name        = "argocd"
    namespace   = "argocd"
    domain      = var.domain
    issuer_name = "letsencrypt-prod"
  })

  depends_on = [kubectl_manifest.argocd]
}
