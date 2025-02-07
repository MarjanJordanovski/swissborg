module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.cluster_name
  cidr = var.vpc_cidr

  # We slice the first `az_count` availability zones
  azs = slice(var.azs, 0, var.az_count)

  # Dynamic subnets using cidrsubnet():
  private_subnets = [
    for index, az in slice(var.azs, 0, var.az_count) :
    cidrsubnet(var.vpc_cidr, 4, index)
  ]

  public_subnets = [
    for index, az in slice(var.azs, 0, var.az_count) :
    cidrsubnet(var.vpc_cidr, 8, index + var.public_subnet_offset)
  ]

  intra_subnets = [
    for index, az in slice(var.azs, 0, var.az_count) :
    cidrsubnet(var.vpc_cidr, 8, index + var.intra_subnet_offset)
  ]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = var.tags
}
