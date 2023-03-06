
data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 19"

  cluster_name    = var.cluster_name
  cluster_version = "1.25"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true
  manage_aws_auth_configmap      = true
  # cluster_additional_security_group_ids = [aws_security_group.eks.id]

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      resolve_conflicts        = "OVERWRITE"
      most_recent              = true
      before_compute           = true
      service_account_role_arn = module.vpc_cni_irsa.iam_role_arn
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  eks_managed_node_group_defaults = {
    ami_type                   = "AL2_x86_64"
    iam_role_attach_cni_policy = true
    # vpc_security_group_ids = [aws_security_group.eks.id]
  }

  eks_managed_node_groups = {
    one = {
      use_custom_launch_template = false
      name                       = "node-group-1"

      instance_types = ["t3.micro"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      use_custom_launch_template = false
      name                       = "node-group-2"

      instance_types = ["t3.micro"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  aws_auth_roles    = var.map_roles
  aws_auth_users    = var.map_users
  aws_auth_accounts = var.map_accounts
}

