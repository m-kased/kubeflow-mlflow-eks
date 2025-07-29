resource "random_password" "grafana_password" {
  length  = 16
  special = true
}

resource "helm_release" "kube_prom_stack" {
  name             = "kube-prom-stack"
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "75.15.1"
  namespace        = "monitoring"
  create_namespace = true

  values = [
    templatefile("${path.module}/values/prom-stack-values.yaml", {
      grafana_password = random_password.grafana_password.result
    })
  ]
}
