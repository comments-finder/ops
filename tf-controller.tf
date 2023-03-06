resource "helm_release" "tf-contoller" {
  name       = "tf-controller"
  repository = "https://weaveworks.github.io/tf-controller/"
  chart      = "tf-controller"
  namespace  = "flux-system"
  set {
    name  = "serviceAccount.create"
    value = true
  }
}