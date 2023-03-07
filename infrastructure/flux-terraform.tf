# resource "kubectl_manifest" "tf-controller-helm-repo" {
#   yaml_body = <<YAML
# apiVersion: source.toolkit.fluxcd.io/v1beta1
# kind: HelmRepository
# metadata:
#   name: tf-controller
#   namespace: flux-system
# spec:
#   interval: 1h0s
#   url: https://weaveworks.github.io/tf-controller/
# YAML
# }

# resource "kubectl_manifest" "tf-controller" {
#   yaml_body = <<YAML
# apiVersion: helm.toolkit.fluxcd.io/v2beta1
# kind: HelmRelease
# metadata:
#   name: tf-controller
#   namespace: flux-system
# spec:
#   chart:
#     spec:
#       chart: tf-controller
#       sourceRef:
#         kind: HelmRepository
#         name: tf-controller
#       version: '>=0.11.0'
#   interval: 1h0s
#   releaseName: tf-controller
#   targetNamespace: flux-system
#   install:
#     crds: Create
#   upgrade:
#     crds: CreateReplace
#   values:
#     replicaCount: 1
#     concurrency: 24
#     resources:
#       limits:
#         cpu: 1000m
#         memory: 2Gi
#       requests:
#         cpu: 400m
#         memory: 64Mi
#     caCertValidityDuration: 24h
#     certRotationCheckFrequency: 30m
#     image:
#       tag: v0.14.0
#     runner:
#       serviceAccount:
#         annotations:
#           eks.amazonaws.com/role-arn: ${module.flux_role.iam_role_arn}
#       image:
#         tag: v0.14.0
#     awsPackage:
#       install: true
#       tag: v4.38.0-v1alpha11
# YAML
# }

# resource "kubectl_manifest" "tf-controller-terraform" {
#   depends_on = [
#     kubectl_manifest.tf-controller-helm-repo,
#     kubectl_manifest.tf-controller,
#   ]
#   yaml_body = <<YAML
# apiVersion: infra.contrib.fluxcd.io/v1alpha1
# kind: Terraform
# metadata:
#   name: flux-terraform
#   namespace: flux-system
# spec:
#   interval: 1m
#   approvePlan: auto
#   path: ./
#   sourceRef:
#     kind: GitRepository
#     name: flux-system
#     namespace: flux-system
# YAML
# }