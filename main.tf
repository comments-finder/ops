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
