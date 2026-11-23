terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.12.0"
}

resource "yandex_container_registry" "registry" {
  name      = var.name
  folder_id = var.folder_id

  labels = var.labels
}

resource "yandex_container_registry_iam_binding" "puller" {
  count = length(var.role) > 0 ? 1 : 0

  registry_id = yandex_container_registry.registry.id
  role        = var.role

  members = var.members
}

#resource "yandex_container_registry_ip_permission" "my_ip_permission" {
#  count = length(var.push_ip) > 0 || length(var.pull_ip) > 0 ? 1 : 0
#
#  registry_id = yandex_container_registry.registry.id
#  push        = var.push_ip
#  pull        = var.pull_ip
#}
