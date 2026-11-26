variable "image_tag" {
  type        = string
  description = "GHCR image tag"
  default     = "2"
}

job "devops-final-task-nginx" {
  datacenters = ["dc1"]
  type        = "service"

  group "nginx" {
    count = 1

    network {
      port "http" {
        to = 8080
      }
    }

    service {
      name     = "devops-final-task-nginx"
      provider = "consul"
      port     = "http"

      check {
        name     = "nginx-http-health"
        type     = "http"
        port     = "http"
        path     = "/healthz"
        interval = "10s"
        timeout  = "2s"
      }
    }

    update {
      max_parallel     = 1
      min_healthy_time = "10s"
      healthy_deadline = "2m"
      auto_revert      = true
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "fail"
    }

    reschedule {
      attempts       = 3
      interval       = "30m"
      delay          = "15s"
      delay_function = "exponential"
      max_delay      = "5m"
      unlimited      = false
    }

    task "nginx" {
      driver = "docker"

      config {
        image = "ghcr.io/samson-olawoyin/devops-final-task-nginx:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }
  }
}
