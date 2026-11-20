variable "name" {
  type = string
  default = "mysql_cluster"
}

variable "environment" {
  type = string
  default = "PRESTABLE"

  validation {
    condition = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "Указано некорректное значение environment. Допустимо PRODUCTION или PRESTABLE"
  }
}

variable "network_id" {
  type = string
}

variable "mysql_version" {
  type = string
  default = "8.0"

  validation {
    condition = contains(["5.7", "8.0", "8.4"], var.mysql_version)
    error_message = "Указана недопустимая версия mysql. Допустимые значение: 5.7; 8.0; 8.4"
  }
}

variable "disk_type" {
  type = string
  default = "network-hdd"

  validation {
    condition = contains(["network-ssd", "network-hdd", "local-ssd", "network-ssd-nonreplicated", "network-ssd-io-m3"], var.disk_type)
    error_message = "Указано недопустимое значение типа диска. Допустимые значения: network-ssd, network-hdd, local-ssd, network-ssd-nonreplicated, network-ssd-io-m3"
  }
}

variable "disk_size" {
  type = number
  default = 10
}

variable "ha" {
  type = bool
  default = true
}

variable "zone" {
  type = string
  default = "ru-central1-a"

  validation {
    condition = contains(["ru-central1-a", "ru-central1-d", "ru-central1-e", "ru-central1-f"], var.zone)
    error_message = "Указана несуществующая зона"
  }
}

variable "subnet_id" {
  type = string
}

variable "public_ip" {
  type = bool
  default = true
}

variable "resource_preset_id" {
  type = string
  default = "b2.medium"
}

variable "security_group_ids" {
  type = list(string)
}
