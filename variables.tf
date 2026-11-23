###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = list(string)
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "security_groups" {
  type = map(object({
    ingress = list(object({
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
    }))
    egress  = list(object({
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
    }))
  }))
}

###common vars

variable "vm_instance_name" {
  type = map(string)
  default = {
    marketing = "marketing"
    analytics = "analytics"
  }
}

variable "vm_public_ip" {
  type = map(bool)
  default = {
    marketing = true
    analytics = true
  }
}

variable "vm_labels" {
  type = map(map(string))

  default = {
    marketing = {
      project = "marketing"
    }
    analytics = {
      project = "analytics"
    }
  }
}

variable "vm_metadata_serial_port" {
  type = map(number)

  default = {
    marketing = 1
    analytics = 1
  }
}

variable "vm_image_family_ubuntu" {
  type = map(string)
  default = {
    marketing = "ubuntu-2004-lts"
    analytics = "ubuntu-2004-lts"
  }
}

variable "vm_cloud_init_packages" {
  type = list(string)

  default = ["vim", "nginx"]
}

variable "vm_security_groups" {
  type = list(string)
}

variable "vm_user" {
  type = string
}
##mysql

variable "mysql_cluster_name" {
  type = string
}

variable "mysql_cluster_ha" {
  type = bool
}

variable "mysql_cluster_zone" {
  type = string
}

variable "mysql_cluster_db_name" {
  type = string
}

variable "mysql_cluster_db_username" {
  type = string
}

variable "mysql_cluster_security_groups" {
  type = list(string)
}

##random_password
variable "random_password_length" {
  type = number
}

variable "random_password_special" {
  type = bool
}

variable "random_password_upper" {
  type = bool
}

variable "random_password_lower" {
  type = bool
}

variable "random_password_numeric" {
  type = bool
}

variable "random_password_override_special" {
  type = string
  default = ""
}

variable "manual_db_password" {
  type = string
  default = ""
}

##docker
variable "docker_image_name" {
  type = string
}

##container_registry
variable "container_registry_name" {
  type = string
  default = "develop-registry"
}

variable "container_registry_labels" {
  type = map(string)

  default = {
    environment = "dev"
  }
}

variable "container_registry_role" {
  type = string
  default = ""
}

variable "container_registry_members" {
  type = list(string)
  default = []
}

##lockbox

variable "lockbox_db_secret_id" {
  type = string
}

variable "lockbox_db_secret_version" {
  type = string
}
