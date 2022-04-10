module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.ddbb_id}-${var.environment}-sg"
  description = "Complete MySQL example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = local.tags

}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "4.2.0"

  identifier = "${var.ddbb_id}-${var.environment}"

  engine               = var.ddbb_engine
  family               = "${var.ddbb_engine}${var.ddbb_major_version}"
  major_engine_version = var.ddbb_major_version

  engine_version    = var.mysql_engine_version
  instance_class    = var.rds_instance_type
  allocated_storage = var.allocated_storage

  db_name  = var.ddbb_name
  username = var.ddbb_user
  port     = var.ddbb_port

  iam_database_authentication_enabled = true
  
  # DB subnet group
  subnet_ids = [module.vpc.database_subnet_group]
  db_subnet_group_name  = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  monitoring_interval = "30"
  monitoring_role_name = "RDSMonitoringRole"
  create_monitoring_role = true



  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = local.tags
}