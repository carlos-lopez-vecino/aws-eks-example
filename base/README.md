## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.9.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db"></a> [db](#module\_db) | terraform-aws-modules/rds/aws | 4.2.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 18.0 |
| <a name="module_irsa_alb"></a> [irsa\_alb](#module\_irsa\_alb) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.14.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.docplanner_go](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.docplanner_php](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.docplanner_go_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.docplanner_php_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_kms_key.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [helm_release.alb_helm](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.alb_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_service_account.alb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | RDS Database allocated storage in GB | `number` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | RDS backup window | `string` | n/a | yes |
| <a name="input_ddbb_engine"></a> [ddbb\_engine](#input\_ddbb\_engine) | RDS Engine | `string` | `"mysql"` | no |
| <a name="input_ddbb_id"></a> [ddbb\_id](#input\_ddbb\_id) | RDS Database ID | `string` | n/a | yes |
| <a name="input_ddbb_major_version"></a> [ddbb\_major\_version](#input\_ddbb\_major\_version) | RDS Mysql Engine Version | `string` | `"5.7"` | no |
| <a name="input_ddbb_name"></a> [ddbb\_name](#input\_ddbb\_name) | RDS Database name | `string` | n/a | yes |
| <a name="input_ddbb_port"></a> [ddbb\_port](#input\_ddbb\_port) | RDS Database connection port | `string` | `"3306"` | no |
| <a name="input_ddbb_user"></a> [ddbb\_user](#input\_ddbb\_user) | RDS Database username | `string` | n/a | yes |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | AWS EKS clusrer version | `string` | n/a | yes |
| <a name="input_eks_instance_types"></a> [eks\_instance\_types](#input\_eks\_instance\_types) | AWS EKS node group allowed instance types | `list(string)` | n/a | yes |
| <a name="input_eks_node_disk_size"></a> [eks\_node\_disk\_size](#input\_eks\_node\_disk\_size) | AWS EKS node group disk size | `number` | n/a | yes |
| <a name="input_eks_node_group_desired_size"></a> [eks\_node\_group\_desired\_size](#input\_eks\_node\_group\_desired\_size) | AWS EKS node group desired size | `number` | n/a | yes |
| <a name="input_eks_node_group_max_size"></a> [eks\_node\_group\_max\_size](#input\_eks\_node\_group\_max\_size) | AWS EKS node group maxk size | `number` | n/a | yes |
| <a name="input_eks_node_group_min_size"></a> [eks\_node\_group\_min\_size](#input\_eks\_node\_group\_min\_size) | AWS EKS node group min size | `number` | n/a | yes |
| <a name="input_eks_private_access"></a> [eks\_private\_access](#input\_eks\_private\_access) | AWS EKS API private endpoint configuration | `bool` | n/a | yes |
| <a name="input_eks_public_access"></a> [eks\_public\_access](#input\_eks\_public\_access) | AWS EKS API public endpoint configuration | `bool` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | AWS Environment name | `string` | n/a | yes |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | RDS maintenance window | `string` | n/a | yes |
| <a name="input_mysql_engine_version"></a> [mysql\_engine\_version](#input\_mysql\_engine\_version) | RDS Mysql Engine Version | `string` | n/a | yes |
| <a name="input_rds_instance_type"></a> [rds\_instance\_type](#input\_rds\_instance\_type) | RDS Instance type | `string` | n/a | yes |
| <a name="input_vpc_azs"></a> [vpc\_azs](#input\_vpc\_azs) | VPC AZ zones | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR | `string` | n/a | yes |
| <a name="input_vpc_database_subnets"></a> [vpc\_database\_subnets](#input\_vpc\_database\_subnets) | VPC Databases Private subnets CIDRs | `list(string)` | n/a | yes |
| <a name="input_vpc_eks_node_pool_private_subnets"></a> [vpc\_eks\_node\_pool\_private\_subnets](#input\_vpc\_eks\_node\_pool\_private\_subnets) | VPC EKS Control Plane Private subnets CIDRs | `list(string)` | n/a | yes |
| <a name="input_vpc_nat_gategway_enabled"></a> [vpc\_nat\_gategway\_enabled](#input\_vpc\_nat\_gategway\_enabled) | VPC NAT Gateway Enabled | `bool` | n/a | yes |
| <a name="input_vpc_public_subnets"></a> [vpc\_public\_subnets](#input\_vpc\_public\_subnets) | VPC Public subnets CIDRs | `list(string)` | n/a | yes |

## Outputs

No outputs.
