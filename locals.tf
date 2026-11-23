locals {
  ssh-pub-key = file(pathexpand("~/.ssh/id_ed25519.pub"))

  security_group_ids_database = [
    for name in var.mysql_cluster_security_groups: module.vpc.security_id_by_name[name]
  ]
  security_group_ids_web = [
    for name in var.vm_security_groups: module.vpc.security_id_by_name[name]
  ]

  env_content = templatefile("${path.module}/env.template", {
    image       = "cr.yandex/${module.container_registry.id}/${var.docker_image_name}"
    db_host     = module.mysql_cluster.host[0].fqdn
    db_password = length(var.manual_db_password) > 0 ? var.manual_db_password : random_password.db_password.result
    db_user     = var.mysql_cluster_db_username
    db_name     = var.mysql_cluster_db_name
  })
}
