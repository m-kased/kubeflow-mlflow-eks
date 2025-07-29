resource "kubectl_manifest" "argocd_gateway" {
  yaml_body = templatefile("${path.module}/templates/gateway.yaml.tpl", {
    name      = "argocd"
    namespace = "argocd"
    domain    = var.domain
  })
}

resource "kubectl_manifest" "argocd_virtualservice" {
  yaml_body = templatefile("${path.module}/templates/virtualservice.yaml.tpl", {
    name      = "argocd"
    namespace = "argocd"
    domain    = var.domain
  })
}

resource "kubectl_manifest" "argocd_certificate" {
  yaml_body = templatefile("${path.module}/templates/certificate.yaml.tpl", {
    name        = "argocd"
    namespace   = "argocd"
    domain      = var.domain
    issuer_name = "letsencrypt-prod"
  })
}

resource "kubectl_manifest" "grafana_gateway" {
  yaml_body = templatefile("${path.module}/templates/gateway.yaml.tpl", {
    name      = "grafana"
    namespace = "monitoring"
    domain    = var.domain
  })
}

resource "kubectl_manifest" "grafana_virtualservice" {
  yaml_body = templatefile("${path.module}/templates/virtualservice.yaml.tpl", {
    name      = "grafana"
    namespace = "monitoring"
    domain    = var.domain
  })
}

resource "kubectl_manifest" "grafana_certificate" {
  yaml_body = templatefile("${path.module}/templates/certificate.yaml.tpl", {
    name        = "grafana"
    namespace   = "monitoring"
    domain      = var.domain
    issuer_name = "letsencrypt-prod"
  })
}
