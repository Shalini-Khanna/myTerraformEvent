resource "kubernetes_deployment" "internal-deployment" {
  metadata {
    name = "internal"
    labels = {
      App = "internal"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 3
    selector {
      match_labels = {
        App = "internal"
      }
    }
    template {
      metadata {
        labels = {
          App = "internal"
        }
      }
      spec {
        container {
          image = "shakhanna/internal:2.0"
          name  = "internal"

          port {
            container_port = 8082
          }

        }
      }
    }
  }
}