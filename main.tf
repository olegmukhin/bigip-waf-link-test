terraform {
  required_providers {
  }
}

variable "application_language" {
  type = string
  default = "utf-8"
}

variable "server_technologies" {
  type = list(string)
  default = [""]
}

locals {
  server_technologies = [for st in var.server_technologies : { serverTechnologies = st }]
}

output "json" {
  value = templatefile("${path.module}/test.tftpl", {
    "application_language" = var.application_language
    "server_technologies" = jsonencode(var.server_technologies[0] != "" ? local.server_technologies : [])
  })
}