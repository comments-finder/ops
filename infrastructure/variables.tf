# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


variable "repository_ssh_url" {
  description = "Repository"
  type        = string
  default     = "ssh://git@github.com/comments-finder/ui.git"
}


variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "search"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = []
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::223024806835:user/user1"
      username = "admin"
      groups   = ["system:masters"]
    },
  ]
}