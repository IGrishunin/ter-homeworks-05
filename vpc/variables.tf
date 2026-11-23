variable "name" {
  type = string
  default = "develop"
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))

  default = [
    {
      zone = "ru-central1-a",
      cidr = "10.100.0.0/16"
    }
  ]

  validation {
    condition = alltrue([
      for v in var.subnets: can(cidrhost(v.cidr, 0))
    ])
    error_message = "Указан некорректный CIDR"
  }

  validation {
    condition = alltrue([
      for v in var.subnets: contains(["ru-central1-a", "ru-central1-d", "ru-central1-e", "ru-central1-f"], v.zone)
    ])
    error_message = "Указана несуществующая зона"
  }
}

variable "folder_id" {
  type = string
}

variable "security_group" {
  type = map(object({
    ingress = list(object({
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
    }))
    egress = list(object({
      protocol       = string
      description    = string
      v4_cidr_blocks = list(string)
      port           = optional(number)
      from_port      = optional(number)
      to_port        = optional(number)
    }))
  }))

  default = {
    security1 = {
      ingress = [
        {
          protocol       = "UDP"
          description    = "разрешить входящий ssh"
          v4_cidr_blocks = ["0.0.0.0/0"]
          port           = 22
        },
        {
          protocol       = "TCP"
          description    = "разрешить входящий  http"
          v4_cidr_blocks = ["0.0.0.0/0"]
          port           = 80
        },
        {
          protocol       = "TCP"
          description    = "разрешить входящий https"
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
          to_port        = 65535
        }
      ]
    }
  }

  validation {
    condition = alltrue([
      for k, v in var.security_group: alltrue([
        for rule in v.ingress: contains(["TCP", "UDP", "ICMP", "AH", "ESP", "GRE"], rule.protocol)
      ]) && alltrue([
	for rule in v.egress: contains(["TCP", "UDP", "ICMP", "AH", "ESP", "GRE"], rule.protocol)
      ])
    ])
    error_message = "Указан неверный протокол в правилах ingress или egress"
  }

  validation {
    condition = alltrue([
      for k, v in var.security_group: alltrue([
        for rule in v.ingress: alltrue([
          for cidr in rule.v4_cidr_blocks: can(cidrhost(cidr, 0))
        ])
      ]) && alltrue([
        for rule in v.egress: alltrue([
          for cidr in rule.v4_cidr_blocks: can(cidrhost(cidr, 0))
        ])
      ])
    ])  
    error_message = "Указана неверная подсеть в блоке v4_cidr_blocks в ingress или egress блоке"
  }

  validation {
    condition = alltrue([
      for k, v in var.security_group: alltrue([
        for rule in v.ingress: (rule.port == null && alltrue([
          rule.from_port != null,
          rule.to_port != null
        ])) || (rule.port != null && alltrue([
          rule.from_port == null,
          rule.to_port == null
	]))
      ]) && alltrue([
        for rule in v.egress: (rule.port == null && alltrue([
          rule.from_port != null,
          rule.to_port != null 
        ])) || (rule.port != null && alltrue([
          rule.from_port == null,
          rule.to_port == null
        ]))
      ])
    ])
    error_message = "Должен быть указан один параметр port или 2 параметра from_port - to_port"
  }

  validation {
    condition = alltrue([
      for k,v in var.security_group: alltrue([
        for rule in v.ingress: ((rule.from_port != null && rule.to_port != null) && (rule.from_port <= rule.to_port)) if rule.port == null
      ]) && alltrue([
        for rule in v.egress: ((rule.from_port != null && rule.to_port != null) && (rule.from_port <= rule.to_port)) if rule.port == null
      ])
    ])
    error_message = "Значение from_port должно быть меньше или равно to_port"
  }
}	
