# module vm

vm_instance_name = {
  web = "web"
}

vm_public_ip = {
  web = true
}

vm_labels = {
  web = {
    project = "web"
  }
}

vm_metadata_serial_port = {
  web = 1
}

vm_image_family_ubuntu = {
  web = "ubuntu-2004-lts"
}

vm_cloud_init_packages = ["docker", "docker-compose-v2", "git"]
default_zone = ["ru-central1-d"]

vm_security_groups = ["sec-web"]

vm_user = "ubuntu"

# module vpc
vpc_subnets = [
  { zone = "ru-central1-a", cidr = "10.0.0.0/24"},
  { zone = "ru-central1-d", cidr = "10.0.1.0/24"},
]

security_groups = {
  sec-web = { 
    ingress = [
      {
        protocol       = "TCP"
        description    = "разрешить входящий ssh"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 22
      },
      { 
        protocol       = "TCP"
        description    = "разрешить входящий трафик на 80"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 80
      },
      {
        protocol       = "TCP"
        description    = "разрешить входящий трафик на 443"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 443
      }
    ]
    egress = [
      {
        protocol       = "TCP"
        description    = "разрешить весь исходящий трафик"
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65365
      }
    ]
  }
  sec-database = {
    ingress = [
      {
        protocol       = "TCP"
        description    = "разрешить входящий ssh"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 22
      },
      {
        protocol       = "TCP"
        description    = "разрешить входящий трафик на 80"
        v4_cidr_blocks = ["0.0.0.0/0"]
        port           = 3306
      }
    ]
    egress = [
      {
        protocol       = "TCP"
        description    = "разрешить весь исходящий трафик"
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65365
      }
    ]
  }

}


# mysql
mysql_cluster_name        = "cluster_web"
mysql_cluster_ha          = false
mysql_cluster_zone        = "ru-central1-d"
mysql_cluster_db_name     = "db_web"
mysql_cluster_db_username = "appweb"
mysql_cluster_security_groups = ["sec-database"]

# random_password
random_password_length  = 16
random_password_special = true
random_password_upper   = true
random_password_lower   = true
random_password_numeric = true

# docker
docker_image_name = "application-web:latest"

#container_registry
container_registry_labels = {
  environment = "dev"
}

container_registry_name = "registry-develop"
container_registry_role = "container-registry.images.puller"
container_registry_members = ["system:allUsers"]
