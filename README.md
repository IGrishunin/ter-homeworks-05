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

#Задача 2
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

#Задача 3
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





