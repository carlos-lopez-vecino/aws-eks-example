module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "vpc-${var.environment}-${var.aws_region}"
  cidr = var.vpc_cidr
  azs = var.vpc_azs

  private_subnets        = var.vpc_eks_node_pool_private_subnets
  private_subnet_suffix  = "eks"
  enable_dns_hostnames   = true
  
  database_subnets             = var.vpc_database_subnets
  create_database_subnet_group = true
  database_subnet_group_name   = "database-subnet"

  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway   = var.vpc_nat_gategway_enabled
  single_nat_gateway  = true
  one_nat_gateway_per_az = false         

  public_subnet_tags = {
    "kubernetes.io/cluster/eks-${var.environment}" = "shared"
    "kubernetes.io/role/elb"                       = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-${var.environment}" = "shared"
    "kubernetes.io/role/internal-elb"              = 1
  }

  tags = {
    Environment = var.environment
    Region      = var.aws_region
  }
}
