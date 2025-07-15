module "vpc" {
  source = "./modules/vpc"

  env            = var.env
  zone1          = var.zone1
  zone2          = var.zone2
  eks_name       = var.eks_name
  terraform_tags = var.terraform_tags
}

module "eks" {
  source = "./modules/eks"

  env             = var.env
  subnet_zone1_id = module.vpc.subnet_zone1_id
  subnet_zone2_id = module.vpc.subnet_zone2_id
  eks_name        = var.eks_name
  terraform_tags  = var.terraform_tags

  depends_on = [module.vpc]
}

module "k8s" {
  source = "./modules/k8s"
  providers = {
    kubectl = kubectl
  }
  env            = var.env
  terraform_tags = var.terraform_tags

  depends_on = [module.eks]
}

module "helm" {
  source = "./modules/helm"

  eks_cluster_name    = module.eks.eks_cluster_name
  vpc_id              = module.vpc.vpc_id
  eks_cluster_node_id = module.eks.eks_cluster_node_id
  region              = var.region
  grafana_password    = var.grafana_password

  depends_on = [module.eks]
}

module "kubeflow" {
  source = "./modules/kubeflow"

  eks_cluster_name            = module.eks.eks_cluster_name
  local_helm_repo             = var.local_helm_repo
  static_email                = var.static_email
  kubeflow_user_profile       = var.kubeflow_user_profile
  tags                        = var.tags
  user_profile_role_arn       = module.eks.user_profile_role_arn
  region                      = var.region
  profile_controller_role_arn = module.eks.profiles_controller_role_arn

  depends_on = [module.eks, module.k8s, module.helm]
}
