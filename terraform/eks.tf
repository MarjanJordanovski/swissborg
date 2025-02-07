module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  # Grants the user who creates the cluster admin rights.
  enable_cluster_creator_admin_permissions = var.cluster_endpoint_public_access

  # "Auto mode" for compute
  cluster_compute_config = {
    enabled    = true
    node_pools = var.eks_node_pools
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = var.tags
}

