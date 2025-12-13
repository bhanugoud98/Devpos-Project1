resource "kubernetes_namespace" "devops_project" {
  metadata {
    name = "devops-resume-project"
  }
}

resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"
    namespace = kubernetes_namespace.devops_project.metadata.0.name
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "backend"
      }
    }
    template {
      metadata {
        labels = {
          app = "backend"
        }
      }
      spec {
        container {
          image = "backend:latest"
          name  = "backend"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  metadata {
    name = "backend"
    namespace = kubernetes_namespace.devops_project.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.backend.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 5000
      target_port = 5000
    }
    type = "ClusterIP"
  }
}
