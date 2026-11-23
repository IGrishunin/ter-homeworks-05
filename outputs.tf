#output "container_registry_id" {
#  value = module.container_registry.id
#}

output "container_registry_image_tag" {
  value = "cr.yandex/${module.container_registry.id}/${var.docker_image_name}"
}
