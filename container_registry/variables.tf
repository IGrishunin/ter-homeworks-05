variable "name" {
  type = string
  default = "develop"
}

variable "folder_id" {
  type = string
}

variable "labels" {
  type = map(string)

  default = {
    environment = "dev"
  }
}

variable "role" {
  type = string
  default = ""
}

variable "members" {
  type = list(string)

  default = []
}

#variable "push_ip" {
#  type = list(string)
#
#  default = []
#
#  validation {
#    condition = alltrue([
#      for ip in var.push_ip: can(cidrhost(ip, 0))
#    ])
#    error_message = "Проверьте корректность указанной подсети в push_ip"
#  }
#}

#variable "pull_ip" {
#  type = list(string)
#
#  default = []
#
#  validation {
#    condition = alltrue([
#      for ip in var.pull_ip: can(cidrhost(ip, 0))
#    ])
#    error_message = "Проверьте корректность указанной подсети в pull_ip"
#  }
#}
