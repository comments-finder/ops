
resource "helm_release" "aws-ebs-csi-driver" {
  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  depends_on = [
    kubernetes_service_account.service-account,
    module.ebs-csi_irsa,
  ]

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.ebs-csi_irsa.iam_role_arn

  }
}
