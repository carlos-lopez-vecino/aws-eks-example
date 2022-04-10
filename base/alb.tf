module "irsa_alb" {
  depends_on = [ module.eks ]  
  
  source         = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name      = "irsa-eks-alb"

  attach_load_balancer_controller_policy = true
  create_role = true
  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["alb:${var.aws-load-balancer-controller}"]
    }
  }
  tags = local.tags
}

resource "kubernetes_namespace" "alb_ingress" {
  depends_on = [ module.eks ]
  metadata {
    name = "alb"
  }
}

resource "kubernetes_service_account" "alb" {
  depends_on = [ module.eks ]  

  metadata {
    name = var.aws-load-balancer-controller
    namespace = kubernetes_namespace.alb_ingress.id
    annotations = {
      "eks.amazonaws.com/role-arn" = module.irsa_alb.iam_role_arn
    }
  }
}

resource "helm_release" "alb_helm" {
  depends_on = [ module.eks ]  

  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = kubernetes_namespace.alb_ingress.id

  set {
    name  = "clusterName"
    value = module.eks.cluster_id
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = var.aws-load-balancer-controller
  }
}
