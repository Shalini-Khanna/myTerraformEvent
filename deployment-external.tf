resource "kubernetes_deployment" "external-deployment" {
  metadata {
    name = "external"
    labels = {
      App = "external"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 3
    selector {
      match_labels = {
        App = "external"
      }
    }
    template {
      metadata {
        labels = {
          App = "external"
        }
      }
      spec {
        container {
          image = "shakhanna/external:2.0"
          name  = "external"

          port {
            container_port = 8080
          }
          env {
            name = "SERVER"
            value = "http://${kubernetes_service.internal-service.metadata[0].name}:8082"
          }

        }
      }
    }
  }
}