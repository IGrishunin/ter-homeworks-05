module "vpc" {
  source = "./vpc"
  name = var.vpc_name
  subnets = var.vpc_subnets
  security_group = var.security_groups
  folder_id = var.folder_id
}

module "web-vm" {
  source             = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=97fe51b7341df99a57ff717e42347e185232fa31"
  network_id         = module.vpc.network_id
  subnet_zones       = var.default_zone
  subnet_ids         = [for zone in var.default_zone : try(module.vpc.subnet_id_by_zone[zone], null)]
  instance_name      = var.vm_instance_name.web
  instance_count     = 1
  image_family       = var.vm_image_family_ubuntu.web
  public_ip          = var.vm_public_ip.web
  labels             = var.vm_labels.web
  security_group_ids = local.security_group_ids_web

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = var.vm_metadata_serial_port.web
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars     = {
    ssh-pub-key = local.ssh-pub-key,
    packages    = jsonencode(var.vm_cloud_init_packages)
    user        = var.vm_user
    env_content = indent(6, local.env_content)
  }
}

resource "random_password" "db_password" {
  length           = var.random_password_length
  special          = var.random_password_special
  upper            = var.random_password_upper
  lower            = var.random_password_lower
  numeric          = var.random_password_numeric
  override_special = var.random_password_override_special
}

data "yandex_lockbox_secret_version" "db_password" {
  count      = length(var.lockbox_db_secret_id) > 0 ? 1 : 0

  secret_id  = var.lockbox_db_secret_id
  version_id = var.lockbox_db_secret_version
}

module "mysql_cluster" {
  source     = "./mysql"
  name       = var.mysql_cluster_name
  zone       = var.mysql_cluster_zone
  network_id = module.vpc.network_id
  ha         = var.mysql_cluster_ha
  subnet_id  = module.vpc.subnet_id_by_zone[var.mysql_cluster_zone]
  security_group_ids = local.security_group_ids_database
}

module "mysql_cluster_content" {
  source      = "./mysql_content"
  cluster_id  = module.mysql_cluster.cluster_id
  db_name     = var.mysql_cluster_db_name
  db_username = var.mysql_cluster_db_username
  db_password = local.db_password
  depends_on  = [module.mysql_cluster]
}

module "container_registry" {
  source    = "./container_registry"
  name      = var.container_registry_name
  labels    = var.container_registry_labels
  folder_id = var.folder_id
  role      = var.container_registry_role
  members   = var.container_registry_members
}
