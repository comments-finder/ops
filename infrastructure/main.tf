terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.18"
    }
  }

  required_version = ">= 1"
}

provider "kubernetes" {
  // Config based auth
  # config_path = "~/.kube/config"

  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}
provider "helm" {
  kubernetes {
    // Config based auth
    # config_path = "~/.kube/config"

    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}