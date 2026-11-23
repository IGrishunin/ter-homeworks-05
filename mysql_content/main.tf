terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">1.12.0"
}

resource "yandex_mdb_mysql_database" "db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "user" {
  cluster_id = var.cluster_id
  name       = var.db_username
  password   = var.db_password
  permission {
    database_name = yandex_mdb_mysql_database.db.name
    roles         = ["ALL"]
  }

  depends_on = [yandex_mdb_mysql_database.db]
}
