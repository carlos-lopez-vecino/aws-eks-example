# AWS variables
environment = "dev"
aws_region = "eu-north-1"


# EKS variables
eks_cluster_version         = "1.22"
eks_instance_types          = ["t3.small", "t3.large", "t3.xlarge"]
eks_node_disk_size          = 50
eks_public_access           = true
eks_private_access          = true
eks_node_group_min_size     = 1
eks_node_group_max_size     = 5
eks_node_group_desired_size = 1
alb_eks_sa                  = "aws-load-balancer-controller"

# Network variables
vpc_cidr                          = "10.0.0.0/16"
vpc_azs                           = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
vpc_public_subnets                = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
vpc_eks_node_pool_private_subnets = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
vpc_database_subnets              = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
vpc_nat_gategway_enabled          = true

# RDS variables
ddbb_engine          = "mysql"
ddbb_major_version   = "5.7"
mysql_engine_version = "5.7.25"
ddbb_id              = "docplanner"
ddbb_name            = "docplanner"
ddbb_user            = "docplanner"
rds_instance_type    = "db.t3.small"
allocated_storage    = 5
maintenance_window   = "Sat:00:00-Sat:03:00"
backup_window        = "00:00-06:00"