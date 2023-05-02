
###############################
# EKS variables
################################
variable "eks_desired_capacity" {
  default = "1"
}

variable "eks_max_capacity" {
  default = "1"
}

variable "eks_min_capacity" {
  default = "1"
}

variable "eks_instance_type" {
  default = "t2.medium"
}

variable "eks_cluster_name" {
  default = "opnvinomodelekscluster"
}

###############################
# AWS VPC variables
################################
variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "vpc_name" {
  default = "opnvino-model-server-vpc"
}

variable "vpc_private_subnets" {
  default = ["172.16.1.0/24", "172.16.2.0/24", "172.16.3.0/24"]
}

variable "vpc_public_subnets" {
  default = ["172.16.4.0/24", "172.16.5.0/24", "172.16.6.0/24"]
}

variable "vpc_enable_nat_gateway" {
  default = true
}

variable "vpc_single_nat_gateway" {
  default = true
}

variable "vpc_enable_dns_hostnames" {
  default = true
}

