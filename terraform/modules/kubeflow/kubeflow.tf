resource "random_string" "minio_access_key" {
  length  = 16
  special = false
}

resource "random_password" "minio_secret_key" {
  length  = 32
  special = false
}

resource "helm_release" "pv_efs" {
  chart     = "${var.local_helm_repo}/pv-efs"
  name      = "pv-efs"
  version   = "1.0.0"
  namespace = "kubeflow"

  set {
    name  = "namespace"
    value = "kubeflow"
  }

  set {
    name  = "efs.fs_id"
    value = aws_efs_file_system.fs.id
  }
}

resource "helm_release" "user_profile_pv_efs" {
  chart     = "${var.local_helm_repo}/pv-efs"
  name      = "user-profile-pv-efs"
  version   = "1.0.0"
  namespace = "kubeflow"

  set {
    name  = "efs.volume_name"
    value = "user-profile-pv-efs"
  }

  set {
    name  = "efs.claim_name"
    value = "pv-efs"
  }

  set {
    name  = "efs.class_name"
    value = "user-profile-efs-sc"
  }

  set {
    name  = "namespace"
    value = "kubeflow-user-example-com"
  }

  set {
    name  = "efs.fs_id"
    value = aws_efs_file_system.fs.id
  }
}

resource "helm_release" "kubeflow-admission-webhook" {
  name      = "kubeflow-admission-webhook"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-admission-webhook"
  version   = "1.0.0"
  namespace = "kubeflow"

  values = [
    <<-EOT
      kubeflow:
        namespace: "kubeflow"
    EOT
  ]

}

resource "helm_release" "kubeflow-profiles-and-kfam" {
  name      = "kubeflow-profiles-and-kfam"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-profiles-and-kfam"
  version   = "1.0.0"
  namespace = "kubeflow"

  values = [
    <<-EOT
      profile_controller:
        role_arn: "${var.profile_controller_role_arn}"
      kubeflow:
        namespace: "kubeflow"
      ingress:
        namespace: "ingress"
        gateway: "ingress-gateway"
        sa: "istio-ingressgateway"
      notebook_controller:
        sa: "notebook-controller-service-account"
      pipeline_ui:
        sa: "ml-pipeline-ui"
    EOT
  ]

  depends_on = [
    helm_release.kubeflow-admission-webhook
  ]
}

resource "helm_release" "kubeflow-notebooks" {
  name      = "kubeflow-notebooks"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-notebooks"
  version   = "1.0.0"
  namespace = "kubeflow"

  values = [
    <<-EOT
      kubeflow:
        namespace: "kubeflow"
      ingress:
        namespace: ""ingress""
        gateway: "ingress-gateway"
        sa: "istio-ingressgateway"
    EOT
  ]

  depends_on = [helm_release.kubeflow-profiles-and-kfam]
}

resource "helm_release" "kubeflow-tensorboards" {
  name      = "kubeflow-tensorboards"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-tensorboards"
  version   = "1.0.0"
  namespace = "kubeflow"

  values = [
    <<-EOT
      kubeflow:
        namespace: "kubeflow"
      ingress:
        namespace: ""ingress""
        gateway: "ingress-gateway"
        sa: "istio-ingressgateway"
    EOT
  ]

  depends_on = [helm_release.kubeflow-profiles-and-kfam]
}

resource "helm_release" "kubeflow-pipelines" {
  name      = "kubeflow-pipelines"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-pipelines"
  version   = "1.0.0"
  namespace = "kubeflow"

  values = [
    <<-EOT
      kubeflow:
        namespace: "kubeflow"
      ingress:
        namespace: ""ingress""
        gateway: "ingress-gateway"
        sa: "istio-ingressgateway"
      minio:
        access_key: "${random_string.minio_access_key.result}"
        secret_key: "${random_password.minio_secret_key.result}"
      
    EOT
  ]

  depends_on = [helm_release.kubeflow-profiles-and-kfam]
}

resource "helm_release" "kubeflow-volumes" {
  name      = "kubeflow-volumes"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-volumes"
  version   = "1.0.0"
  namespace = "kubeflow"

  values = [
    <<-EOT
      kubeflow:
        namespace: "kubeflow"
      ingress:
        namespace: ""ingress""
        gateway: "ingress-gateway"
        sa: "istio-ingressgateway"
      
    EOT
  ]

  depends_on = [helm_release.kubeflow-profiles-and-kfam]
}

resource "helm_release" "kubeflow-user-profile" {
  name      = "kubeflow-user-profile"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-user-profile"
  version   = "1.0.0"
  namespace = "kubeflow"

  values = [
    <<-EOT
      user: 
        email: ${var.static_email}
        profile: ${var.kubeflow_user_profile}
      awsIamForServiceAccount:
        awsIamRole: ${var.user_profile_role_arn}
    EOT
  ]

  depends_on = [helm_release.kubeflow-profiles-and-kfam]
}

resource "helm_release" "kubeflow-katib" {
  name      = "kubeflow-katib"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-katib"
  version   = "1.0.1"
  namespace = "kubeflow"

  values = [
    <<-EOT
      kubeflow:
        namespace: "kubeflow"
      ingress:
        namespace: ""ingress""
        gateway: "ingress-gateway"
        sa: "istio-ingressgateway"
      
    EOT
  ]

  depends_on = [helm_release.kubeflow-pipelines]
}

resource "helm_release" "kubeflow-user-profile-defaults" {
  name      = "kubeflow-user-profile-defaults"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-user-profile-defaults"
  version   = "1.0.7"
  namespace = "kubeflow"

  values = [
    <<-EOT
      user: 
        profile: ${var.kubeflow_user_profile}
    EOT
  ]

  depends_on = [helm_release.kubeflow-user-profile]
}

resource "helm_release" "kubeflow-central-dashboard" {
  name      = "kubeflow-central-dashboard"
  chart     = "${var.local_helm_repo}/ml-platform/kubeflow-central-dashboard"
  version   = "1.0.0"
  namespace = "kubeflow"

  values = [
    <<-EOT
      kubeflow:
        namespace: "kubeflow"
      user: 
        profile: ${var.kubeflow_user_profile}
      ingress:
        namespace: ""ingress""
        gateway: "ingress-gateway"
        sa: "istio-ingressgateway"
    EOT
  ]

  depends_on = [
    helm_release.pv_efs,
    helm_release.user_profile_pv_efs,
    helm_release.kubeflow-user-profile-defaults,
    helm_release.kubeflow-tensorboards,
    helm_release.kubeflow-volumes,
    helm_release.kubeflow-pipelines,
    helm_release.kubeflow-katib
  ]
}
