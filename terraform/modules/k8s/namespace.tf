resource "kubernetes_namespace" "kubeflow" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }

    name = "kubeflow"
  }
}
