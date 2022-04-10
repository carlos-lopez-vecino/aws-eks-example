#AWS Variables
variable "environment" {
  description = "AWS Environment name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

# EKS variables
variable "eks_cluster_version" {
  description = "AWS EKS clusrer version"
  type        = string
}

variable "eks_instance_types" {
  description = "AWS EKS node group allowed instance types"
  type        = list(string)
}

variable "eks_node_disk_size" {
  description = "AWS EKS node group disk size"
  type        = number
}

variable "eks_node_group_min_size" {
  description = "AWS EKS node group min size"
  type        = number
}

variable "eks_node_group_desired_size" {
  description = "AWS EKS node group desired size"
  type        = number
}


variable "eks_node_group_max_size" {
  description = "AWS EKS node group maxk size"
  type        = number
}

variable "eks_public_access" {
  description = "AWS EKS API public endpoint configuration"
  type        = bool
}

variable "eks_private_access" {
  description = "AWS EKS API private endpoint configuration"
  type        = bool
}

variable "alb_eks_sa" {
  description = "ALB EKS service account"
  type        = string
}

# Network variables

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "vpc_azs" {
  description = "VPC AZ zones"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "VPC Public subnets CIDRs"
  type        = list(string)
}

variable "vpc_eks_node_pool_private_subnets" {
  description = "VPC EKS Control Plane Private subnets CIDRs"
  type        = list(string)
}

variable "vpc_database_subnets" {
  description = "VPC Databases Private subnets CIDRs"
  type        = list(string)
}


variable "vpc_nat_gategway_enabled" {
  description = "VPC NAT Gateway Enabled"
  type        = bool
}

# Databases variables

variable "ddbb_engine" {
  description = "RDS Engine"
  type        = string
  default     = "mysql"
}

variable "ddbb_major_version" {
  description = "RDS Mysql Engine Version"
  type        = string
  default     = "5.7"
}

variable "mysql_engine_version" {
  description = "RDS Mysql Engine Version"
  type        = string
}

variable "rds_instance_type" {
  description = "RDS Instance type"
  type        = string
}

variable "maintenance_window" {
  description = "RDS maintenance window"
  type        = string
}

variable "backup_window" {
  description = "RDS backup window"
  type        = string
}

variable "ddbb_id" {
  description = "RDS Database ID"
  type        = string
}

variable "ddbb_name" {
  description = "RDS Database name"
  type        = string
}

variable "ddbb_user" {
  description = "RDS Database username"
  type        = string
}

variable "ddbb_port" {
  description = "RDS Database connection port"
  type        = string
  default     = "3306"
}

variable "allocated_storage" {
  description = "RDS Database allocated storage in GB"
  type        = number
}
