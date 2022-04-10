
locals {
  tags = {
    Environment              = var.environment
    Region                   = var.aws_region
  }
}

resource "aws_kms_key" "eks" {
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = local.tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.0"

  cluster_name    = "eks-${var.environment}"
  cluster_version = var.eks_cluster_version
  enable_irsa = true

  cluster_endpoint_private_access = var.eks_public_access
  cluster_endpoint_public_access  = var.eks_private_access

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }

  }

  cluster_encryption_config = [{
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }]

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }


  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = var.eks_node_disk_size
    instance_types = var.eks_instance_types

    # We are using the IRSA created below for permissions
    # However, we have to deploy with the policy attached FIRST (when creating a fresh cluster)
    # and then turn this off after the cluster/node group is created. Without this initial policy,
    # the VPC CNI fails to assign IPs and nodes cannot join the cluster
    # See https://github.com/aws/containers-roadmap/issues/1666 for more context
    iam_role_attach_cni_policy = true
    iam_role_additional_policies = [
      "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    ]
    min_size     = var.eks_node_group_min_size
    max_size     = var.eks_node_group_max_size
    desired_size = var.eks_node_group_desired_size


  }

  eks_managed_node_groups = {
    # Default node group - as provided by AWS EKS
    default_node_group = {
      # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
      # so we need to disable it to use the default template provided by the AWS EKS managed node group service
      create_launch_template = false
      launch_template_name   = ""
    }
  }

  tags = local.tags
 
}

# resource "aws_iam_role_policy_attachment" "ecr_php" {
#   for_each = module.eks.eks_managed_node_groups

#   policy_arn = aws_ecr_repository_policy.docplanner_php_policy.arn
#   role       = each.value.iam_role_name
# }

# resource "aws_iam_role_policy_attachment" "ecr_go" {
#   for_each = module.eks.eks_managed_node_groups

#   policy_arn = aws_ecr_repository_policy.docplanner_go_policy.arn
#   role       = each.value.iam_role_name
# }