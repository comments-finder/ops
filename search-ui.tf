

resource "kubernetes_namespace" "search-ui" {
  metadata {
    name = "search-ui"
  }
}

resource "kubernetes_deployment" "search-ui" {
  metadata {
    name      = "search-ui"
    namespace = "search-ui"
    labels = {
      name = "search-ui"
      test = "1"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        name = "search-ui"
      }
    }

    template {
      metadata {
        labels = {
          name = "search-ui"
        }
      }

      spec {
        image_pull_secrets {
          name = "ghcr-secret"
        }
        container {
          image = "ghcr.io/danxil/search-ui:release_v0.0.6"
          name  = "search-ui"
          port {
            container_port = 1000
          }


          resources {
            limits = {
              cpu    = "0.1"
              memory = "100Mi"
            }
            requests = {
              cpu    = "0.05"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "search-ui" {
  metadata {
    name      = "search-ui"
    namespace = "search-ui"
  }
  spec {
    selector = {
      name = "search-ui"
    }
    port {
      port        = 1000
      target_port = 1000
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress_v1" "router" {
  metadata {
    name      = "router"
    namespace = "search-ui"
    annotations = {
      "alb.ingress.kubernetes.io/scheme" : "internet-facing"
      "kubernetes.io/ingress.class" : "alb"
      "alb.ingress.kubernetes.io/target-type": "instance"
    }
  }
  spec {
    ingress_class_name = "alb"
    rule {
      http {
        path {
          backend {
            service {
                name = kubernetes_service.search-ui.metadata.0.name
                port {
                    number = 1000
                }
            }
          }

          path = "/"
        }
      }
    }
  }
}