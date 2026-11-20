# ter-homeworks-05
# Задача 1
Результат выполнения ```tflint``` в коде проекта src
```
4 issue(s) found:

Warning: Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)

  on providers.tf line 3:
   3:     yandex = {
   4:       source = "yandex-cloud/yandex"
   5:     }

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] variable "vms_ssh_root_key" is declared but not used (terraform_unused_declarations)

  on variables.tf line 36:
  36: variable "vms_ssh_root_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vm_web_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 43:
  43: variable "vm_web_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vm_db_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 50:
  50: variable "vm_db_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_unused_declarations.md
```
Проблемы:
1) Не указана версия провайдера Яндекс
2) Переменная **vms_ssh_root_key** объявлена, но нигде не используется
3) Переменная **vm_web_name** объявлена, но нигде не используется
4) Переменная **vm_db_name** объявлена, но нигде не используется
Результат выполнения ```checkov --skip-download -d .``` в src
Проблем не обнаружено

Результат выполнения ```tflint``` в коде проекта demostration1:
Проблем не обнаружено

Результат выполнения ```checkov --skip-download -d .``` в demostration1:
```
[ kubernetes framework ]: 100%|████████████████████|[1/1], Current File Scanned=vms/cloud-init.yml
2026-11-19 15:40:55,849 [MainThread  ] [WARNI]  Failed to download module git::https://github.com/udjin10/yandex_compute_instance.git?ref=main (for external modules, the --download-external-modules flag is required)
[ terraform framework ]: 100%|████████████████████|[7/7], Current File Scanned=vms/variables.tf                 
[ secrets framework ]: 100%|████████████████████|[8/8], Current File Scanned=./passwords/remote_state_outputs.tf
[ ansible framework ]: 100%|████████████████████|[1/1], Current File Scanned=vms/cloud-init.yml

       _               _
   ___| |__   ___  ___| | _______   __
  / __| '_ \ / _ \/ __| |/ / _ \ \ / /
 | (__| | | |  __/ (__|   < (_) \ V /
  \___|_| |_|\___|\___|_|\_\___/ \_/

By Prisma Cloud | version: 3.4.6 

terraform scan results:

Passed checks: 0, Failed checks: 4, Skipped checks: 0

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: test-vm
        File: /vms/main.tf:22-43

                22 | module "test-vm" {
                23 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                24 |   env_name       = "develop" 
                25 |   network_id     = yandex_vpc_network.develop.id
                26 |   subnet_zones   = ["ru-central1-a","ru-central1-b"]
                27 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
                28 |   instance_name  = "webs"
                29 |   instance_count = 2
                30 |   image_family   = "ubuntu-2004-lts"
                31 |   public_ip      = true
                32 | 
                33 |   labels = { 
                34 |     owner= "i.ivanov",
                35 |     project = "accounting"
                36 |      }
                37 | 
                38 |   metadata = {
                39 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                40 |     serial-port-enable = 1
                41 |   }
                42 | 
                43 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: test-vm
        File: /vms/main.tf:22-43

                22 | module "test-vm" {
                23 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                24 |   env_name       = "develop" 
                25 |   network_id     = yandex_vpc_network.develop.id
                26 |   subnet_zones   = ["ru-central1-a","ru-central1-b"]
                27 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id,yandex_vpc_subnet.develop_b.id]
                28 |   instance_name  = "webs"
                29 |   instance_count = 2
                30 |   image_family   = "ubuntu-2004-lts"
                31 |   public_ip      = true
                32 | 
                33 |   labels = { 
                34 |     owner= "i.ivanov",
                35 |     project = "accounting"
                36 |      }
                37 | 
                38 |   metadata = {
                39 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                40 |     serial-port-enable = 1
                41 |   }
                42 | 
                43 | }

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: example-vm
        File: /vms/main.tf:45-61

                45 | module "example-vm" {
                46 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                47 |   env_name       = "stage"
                48 |   network_id     = yandex_vpc_network.develop.id
                49 |   subnet_zones   = ["ru-central1-a"]
                50 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id]
                51 |   instance_name  = "web-stage"
                52 |   instance_count = 1
                53 |   image_family   = "ubuntu-2004-lts"
                54 |   public_ip      = true
                55 | 
                56 |   metadata = {
                57 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                58 |     serial-port-enable = 1
                59 |   }
                60 | 
                61 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: example-vm
        File: /vms/main.tf:45-61

                45 | module "example-vm" {
                46 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                47 |   env_name       = "stage"
                48 |   network_id     = yandex_vpc_network.develop.id
                49 |   subnet_zones   = ["ru-central1-a"]
                50 |   subnet_ids     = [yandex_vpc_subnet.develop_a.id]
                51 |   instance_name  = "web-stage"
                52 |   instance_count = 1
                53 |   image_family   = "ubuntu-2004-lts"
                54 |   public_ip      = true
                55 | 
                56 |   metadata = {
                57 |     user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
                58 |     serial-port-enable = 1
                59 |   }
                60 | 
                61 | }
```
Проблемы:
1) Требует указать хеш коммита для модуля в блоке source
2) Требует указать версию модуля отдельным тегом(не в блоке source)

# Задача 2
В **providers.tf** добавил секцию **backend**
```
backend "s3" {
    profile = "default"
    bucket  = "simple-bucket-izb3ldj2"
    key     = "terraform.tfstate"
    region  = "ru-central1"

    use_lockfile = true

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
```
Создал в домашнем каталоге пользователя **.aws/credentials** и записал туда статический ключ от сервисного аккаунта
Выполнил ```terraform ini -migrate-state``` и получил вывод:
```
Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "s3" backend. No existing state was found in the newly
  configured "s3" backend. Do you want to copy this state to the new "s3"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: yes


Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
Initializing modules...
Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Reusing previous version of hashicorp/random from the dependency lock file
- Reusing previous version of hashicorp/template from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.250.0
- Using previously-installed hashicorp/random v3.9.1
- Using previously-installed hashicorp/template v2.2.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
Запустил ```terraform console```, а в другом окне ```terraform plan```. Получил ошибку блокировки:
```
Error: Error acquiring the state lock
│ 
│ Error message: operation error S3: PutObject, https response error StatusCode: 412, RequestID: 3ea51e4cc6413244, HostID: , api error PreconditionFailed: At least
│ one of the pre-conditions you specified did not hold
│ Lock Info:
│   ID:        12106dae-3405-d728-a764-6b70490b2383
│   Path:      simple-bucket-izb3ldj2/terraform.tfstate
│   Operation: OperationTypeInvalid
│   Who:       i.grishunin@igrishunin.mfcl.mfclnr.ru
│   Version:   1.14.6
│   Created:   2026-11-19 13:44:52.804498808 +0000 UTC
│   Info:      
│ 
│ 
│ Terraform acquires a state lock to protect the state from being written
│ by multiple users at the same time. Please resolve the issue above and try
│ again. For most commands, you can disable locking with the "-lock=false"
│ flag, but this is not recommended.
```
Выполнил ```terraform force-unlock 12106dae-3405-d728-a764-6b70490b2383``` 
```
Do you really want to force-unlock?
  Terraform will remove the lock on the remote state.
  This will allow local Terraform commands to modify this state, even though it
  may still be in use. Only 'yes' will be accepted to confirm.

  Enter a value: yes

Terraform state has been successfully unlocked!

The state has been unlocked, and Terraform commands should now be able to
obtain a new lock on the remote state.
```
После этого ```terraform plan``` сработал

# Задача 3
Создал новую ветку terraform-hotfix командой ```git checkout -b terraform-hotfix```
Проверил код через ```tflint``` и получил следующие предупреждения:
```
i.grishunin@igrishunin:~/NETOLOGY/ter-homework-04$ tflint
8 issue(s) found:

Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 8:
   8:   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_module_pinned_source.md

Warning: Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)

  on main.tf line 25:
  25:   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_module_pinned_source.md

Warning: Missing version constraint for provider "template" in `required_providers` (terraform_required_providers)

  on main.tf line 41:
  41: data "template_file" "cloudinit" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_required_providers.md

Warning: Missing version constraint for provider "random" in `required_providers` (terraform_required_providers)

  on main.tf line 50:
  50: resource "random_password" "db_password" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_required_providers.md

Warning: Missing version constraint for provider "yandex" in `required_providers` (terraform_required_providers)

  on providers.tf line 3:
   3:     yandex = {
   4:       source = "yandex-cloud/yandex"
   5:     }

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_required_providers.md

Warning: [Fixable] variable "vms_ssh_root_key" is declared but not used (terraform_unused_declarations)

  on variables.tf line 42:
  42: variable "vms_ssh_root_key" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vm_web_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 49:
  49: variable "vm_web_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_unused_declarations.md

Warning: [Fixable] variable "vm_db_name" is declared but not used (terraform_unused_declarations)

  on variables.tf line 56:
  56: variable "vm_db_name" {

Reference: https://github.com/terraform-linters/tflint-ruleset-terraform/blob/v0.17.0/docs/rules/terraform_unused_declarations.md
```
Для устранения добавил в файл **providers.tf** в блок с **required_providers**
```
random = {
      source  = "hashicorp/random"
      version = ">= 3.6"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 0.1"
    }
```
И в main.tf в модулях изменил **git::https://github.com/udjin10/yandex_compute_instance.git?ref=main** на **git::https://github.com/udjin10/yandex_compute_instance.git?ref=v2.1.0**

Проверил код через ```checkov --skip-download -d .``` и получил следующие предупреждения:
```
Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: marketing-vm
        File: /main.tf:7-22

                7  | module "marketing-vm" {
                8  |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                9  |   network_id     = module.vpc.network_id
                10 |   subnet_zones   = var.default_zone
                11 |   subnet_ids     = [for zone in var.default_zone : try(module.vpc.subnet_id_by_zone[zone], null)]
                12 |   instance_name  = var.vm_instance_name.marketing
                13 |   instance_count = 2
                14 |   image_family   = var.vm_image_family_ubuntu.marketing
                15 |   public_ip      = var.vm_public_ip.marketing
                16 |   labels         = var.vm_labels.marketing
                17 | 
                18 |   metadata = {
                19 |     user-data          = data.template_file.cloudinit.rendered
                20 |     serial-port-enable = var.vm_metadata_serial_port.analytics
                21 |   }
                22 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: marketing-vm
        File: /main.tf:7-22

                7  | module "marketing-vm" {
                8  |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                9  |   network_id     = module.vpc.network_id
                10 |   subnet_zones   = var.default_zone
                11 |   subnet_ids     = [for zone in var.default_zone : try(module.vpc.subnet_id_by_zone[zone], null)]
                12 |   instance_name  = var.vm_instance_name.marketing
                13 |   instance_count = 2
                14 |   image_family   = var.vm_image_family_ubuntu.marketing
                15 |   public_ip      = var.vm_public_ip.marketing
                16 |   labels         = var.vm_labels.marketing
                17 | 
                18 |   metadata = {
                19 |     user-data          = data.template_file.cloudinit.rendered
                20 |     serial-port-enable = var.vm_metadata_serial_port.analytics
                21 |   }
                22 | }

Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
        FAILED for resource: analytics-vm
        File: /main.tf:24-39

                24 | module "analytics-vm" {
                25 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                26 |   network_id     = module.vpc.network_id
                27 |   subnet_zones   = var.default_zone
                28 |   subnet_ids     = [for zone in var.default_zone : try(module.vpc.subnet_id_by_zone[zone], null)]
                29 |   instance_name  = var.vm_instance_name.analytics
                30 |   instance_count = 1
                31 |   image_family   = var.vm_image_family_ubuntu.analytics
                32 |   public_ip      = var.vm_public_ip.analytics
                33 |   labels         = var.vm_labels.analytics
                34 | 
                35 |   metadata = {
                36 |     user-data          = data.template_file.cloudinit.rendered
                37 |     serial-port-enable = var.vm_metadata_serial_port.analytics
                38 |   }
                39 | }

Check: CKV_TF_2: "Ensure Terraform module sources use a tag with a version number"
        FAILED for resource: analytics-vm
        File: /main.tf:24-39

                24 | module "analytics-vm" {
                25 |   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
                26 |   network_id     = module.vpc.network_id
                27 |   subnet_zones   = var.default_zone
                28 |   subnet_ids     = [for zone in var.default_zone : try(module.vpc.subnet_id_by_zone[zone], null)]
                29 |   instance_name  = var.vm_instance_name.analytics
                30 |   instance_count = 1
                31 |   image_family   = var.vm_image_family_ubuntu.analytics
                32 |   public_ip      = var.vm_public_ip.analytics
                33 |   labels         = var.vm_labels.analytics
                34 | 
                35 |   metadata = {
                36 |     user-data          = data.template_file.cloudinit.rendered
                37 |     serial-port-enable = var.vm_metadata_serial_port.analytics
                38 |   }
                39 | }

Check: CKV_YC_1: "Ensure security group is assigned to database cluster."
        FAILED for resource: module.mysql_cluster.yandex_mdb_mysql_cluster.cluster
        File: /mysql/main.tf:10-36
        Calling File: /main.tf:59-66

                10 | resource "yandex_mdb_mysql_cluster" "cluster" {
                11 |   name                = var.name
                12 |   environment         = var.environment
                13 |   network_id          = var.network_id
                14 |   version             = var.mysql_version
                15 | 
                16 |   resources {
                17 |     resource_preset_id = var.resource_preset_id
                18 |     disk_type_id       = var.disk_type
                19 |     disk_size          = var.disk_size
                20 |   }
                21 | 
                22 |   host {
                23 |     zone             = var.zone
                24 |     subnet_id        = var.subnet_id
                25 |     assign_public_ip = var.public_ip
                26 |   }
                27 | 
                28 |   dynamic "host" {
                29 |     for_each = range(var.ha ? 1 : 0)
                30 |     content {
                31 |       zone             = var.zone
                32 |       subnet_id        = var.subnet_id
                33 |       assign_public_ip = var.public_ip
                34 |     }
                35 |   }
                36 | }
```
Для начала Исправил ошибки **Ensure Terraform module sources use a commit hash** и добавил хеш необходимого коммита ```git::https://github.com/udjin10/yandex_compute_instance.git?ref=97fe51b7341df99a57ff717e42347e185232fa31```. Далее для исправления предупреждения об отсутствии групп безопасности у кластера баз данных решил модифицировать модуль **vpc**. Добавил в **vpc/main.tf** ресурс **yandex_vpc_security_group**:
```
resource "yandex_vpc_security_group" "security" {
  for_each = var.security_group

  name       = each.key
  network_id = yandex_vpc_network.network.id
  folder_id  = var.folder_id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      protocol       = lookup(ingress.value, "protocol", null)
      description    = lookup(ingress.value, "description", null)
      port           = lookup(ingress.value, "port", null)
      from_port      = lookup(ingress.value, "from_port", null)
      to_port        = lookup(ingress.value, "to_port", null)
      v4_cidr_blocks = lookup(ingress.value, "v4_cidr_blocks", null)
    }
  }

  dynamic "egress" {
    for_each = each.value.egress
    content {
      protocol       = lookup(egress.value, "protocol", null)
      description    = lookup(egress.value, "description", null)
      port           = lookup(egress.value, "port", null)
      from_port      = lookup(egress.value, "from_port", null)
      to_port        = lookup(egress.value, "to_port", null)
      v4_cidr_blocks = lookup(egress.value, "v4_cidr_blocks", null)
    }
  }
}
```
Далее в **vpc/variables.tf** переменную **security_group**:
```
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
          protocol       = "TCP"
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
          to_port        = 65365
        }
      ]
    }
  }
}       
```
Переменная была создана именно в таком виде, потому что я хотел, чтобы можно было создавать сразу несколько разных групп безопасности в рамках модуля **vpc**, а далее добавлять их к необходимым ресурсам в любом количестве. Поэтому мы в ресурсе с группами безопасности итерируемся по ключам(названиям групп безопасности), создавая такое количество групп безопасностей сколько имён у мапы в переменной **security_group**, а внутри них уже добавляем необходимое количество **ingress** и **egress** правил.
Также для получения **id** группы безопасностей в рут модуле был создан **output**:
```
output "security_id_by_name" {
  value = { for k, v in yandex_vpc_security_group.security: v.name => v.id }
}
```
В котором id необходимой группы можно получить через её имя

Далее в рут модуле **main.tf** был отредактирован модуль **vpc**, а именно добавлены поля **security_group** и **folder_id**:
```
module "vpc" {
  source = "./vpc"
  name = var.vpc_name
  subnets = var.vpc_subnets
  security_group = var.security_groups 
  folder_id = var.folder_id
}
```
А также был отредактирован модуль **mysql_cluster**(как в рут модуле, так и в папке самого модуля mysql) и добавлено поле ```security_group_ids = local.security_group_ids``` в рут модуле и ```security_group_ids  = var.security_group_ids``` в папке с самим модулем. Обращение к locals пришлось использовать т.к. не было возможности передать список из групп безопасности динамически... Можно было только передать значение в виде ```module.vpc.security_id_by_name[var.security_group_name]```, но в таком случае можно привязать только 1 группу безопасности, поэтому в locals было добавлено формирование списка:
```
security_group_ids = [
    for name in var.mysql_cluster_security_groups: module.vpc.security_id_by_name[name]
  ]
```
А также добавлены переменные в **variables.tf**:
```
variable "mysql_cluster_security_groups" {
  type = list(string)
}
```
и
```
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
```
В terraform.tfvars декларация групп безопасности выглядит так:
```
security_groups = {
  sec1 = {
    ingress = [
      {
        protocol       = "TCP"
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
        description    = "разрешить входящий трафик на СУБД"
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
```
А указание необходимые групп безопасности для привязки к кластеру БД так:
```
mysql_cluster_security_groups = ["sec-database"]
```

Ссылка на PR <a>https://github.com/IGrishunin/ter-homework-04/pull/2/files</a>

# Задача 4
Была добавлена валидация переменных в модуле **vpc** и модуле **mysql**.
**VPC**:
```
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
```
Также валидация **security_group** в **VPC**:
```
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
```
Примеры выполнения валидации:
1) Меняем протокол в **security_group** на TCP1
```
Error: Invalid value for variable
│ 
│   on variables.tf line 38:
│   38: variable "security_group" {
│     ├────────────────
│     │ var.security_group is map of object with 1 element
│ 
│ Указан неверный протокол в правилах ingress или egress
│ 
│ This was checked by the validation rule at variables.tf:92,3-13.
```
2) Меняем **from_port** на значение больше, чем **to_port**:
```
Error: Invalid value for variable
│ 
│   on variables.tf line 38:
│   38: variable "security_group" {
│     ├────────────────
│     │ var.security_group is map of object with 1 element
│ 
│ Значение from_port должно быть меньше или равно to_port
│ 
│ This was checked by the validation rule at variables.tf:141,3-13.
```
3) Меняем v4_cidr_blocks = ["0.0.0.0/0"] на ["0.0.0.0/0", "10.300.0.0/16"]:
```
Error: Invalid value for variable
│ 
│   on variables.tf line 38:
│   38: variable "security_group" {
│     ├────────────────
│     │ var.security_group is map of object with 1 element
│ 
│ Указана неверная подсеть в блоке v4_cidr_blocks в ingress или egress блоке
│ 
│ This was checked by the validation rule at variables.tf:103,3-13.
```
Также в задании требуется написать проверку **ip**, а не подсети. Для этого создадим отдельное правило:
```
variable "ip" {
  type = string
  default = "192.168.0.1"
  validation {
    condition = can(cidrhost("${var.ip}/32", 0))
    error_message = "test ip"
  }
}
```
Так как **cidrhost()** обязательно требует указать маску сети, то принудительно ставим 32 для проверки
Вывод с неправильным значением **1920.168.0.1**:
```
Error: Invalid value for variable
│ 
│   on variables.tf line 153:
│  153: variable "ip" {
│     ├────────────────
│     │ var.ip is "1920.168.0.1"
│ 
│ test ip
│ 
│ This was checked by the validation rule at variables.tf:156,3-13.
```

# Задача 5
1) Создал переменную test_string:
```
variable "test_string" {
  type = string
  default = "teSt"

  validation {
    condition = var.test_string == lower(var.test_string)
    error_message = "Строка содержит заглавные буквы"
  }
}
```
Если одна из букв заглавная, то получаю:
```
Error: Invalid value for variable
│ 
│   on variables.tf line 180:
│  180: variable "test_string" {
│     ├────────────────
│     │ var.test_string is "teSt"
│ 
│ Строка содержит заглавные буквы
│ 
│ This was checked by the validation rule at variables.tf:184,3-13.
```
Иначе всё проходит

3) Создал переменную с валидацией:
```
variable "in_the_end_there_can_be_only_one" {
  description="Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })

  default = {
    Dunkan = false
    Connor = false
  }

  validation {
    error_message = "There can be only one MacLeod"
    condition = (var.in_the_end_there_can_be_only_one.Dunkan == true && var.in_the_end_there_can_be_only_one.Connor == false) || (var.in_the_end_there_can_be_only_one.Connor == true && var.in_the_end_there_can_be_only_one.Dunkan == false)
  }
}
```
Вывод, если обе **false** или **true**:
```
Error: Invalid value for variable
│ 
│   on variables.tf line 162:
│  162: variable "in_the_end_there_can_be_only_one" {
│     ├────────────────
│     │ var.in_the_end_there_can_be_only_one.Connor is false
│     │ var.in_the_end_there_can_be_only_one.Dunkan is false
│ 
│ There can be only one MacLeod
│ 
│ This was checked by the validation rule at variables.tf:174,3-13.
╵

╷
│ Warning: Due to the problems above, some expressions may produce unexpected results.
```
Если значения разные, то предупреждений нету
