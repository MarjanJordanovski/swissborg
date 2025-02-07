variable "cluster_name" {
  type    = string
  default = "swissborg-cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.31"
}

variable "eks_version" {
  type    = string
  default = "~> 20.31"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
  description = "Whether the EKS cluster API is publicly accessible."
}

variable "enable_cluster_creator_admin_permissions" {
  type    = bool
  default = true
  description = "Adds the current identity as cluster admin automatically."
}

variable "eks_node_pools" {
  type    = list(string)
  default = ["general-purpose"]
  description = "List of node pool names for auto mode."
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  description = "List of availability zones to use."
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
  description = "CIDR range for the VPC."
}

variable "az_count" {
  type    = number
  default = 3
  description = "How many AZs to use for subnets."
}

variable "public_subnet_offset" {
  type    = number
  default = 48
  description = "Offset for calculating public subnets using cidrsubnet()."
}

variable "intra_subnet_offset" {
  type    = number
  default = 52
  description = "Offset for calculating intra (or private) subnets using cidrsubnet()."
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "swissborg"
    Terraform   = "true"
  }
  description = "Global tags applied to all resources."
}