resource "helm_release" "istio-base" {
  name             = "istio-base"
  namespace        = "istio-system"
  create_namespace = true
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "base"
  version          = "1.26.0"

  timeout = 1200
  wait    = true
}

resource "helm_release" "istiod" {
  name             = "istiod"
  namespace        = "istio-system"
  create_namespace = true
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "istiod"
  version          = "1.26.0"

  values = ["${path.module}/values/istio.yaml"]

  timeout = 1200
  wait    = true
  depends_on = [
    helm_release.istio-base,
  ]
}

resource "helm_release" "istio-ingress" {
  name             = "istio-ingress"
  namespace        = "istio-ingress"
  create_namespace = true
  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "gateway"
  version          = "1.26.0"

  values = ["${path.module}/values/istio_ingress.yaml"]

  timeout = 1200
  wait    = true
  depends_on = [
    helm_release.istio-base,
    helm_release.istiod,
  ]
}
