
job "devops-final-task-nginx" {
  datacenters = ["dc1"]
  type        = "service"

  group "nginx" {
    count = 1

    network {
      port "http" {
        static = 8080
        to     = 80
      }
    }

    service {
      name     = "devops-final-task-nginx"
      provider = "nomad"
      port     = "http"

      check {
        name     = "nginx-http-health"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "ghcr.io/samson-olawoyin/devops-final-task-nginx:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
