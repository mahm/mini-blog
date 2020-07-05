provider "azurerm" {
  features {}
}

resource "azurerm_postgresql_server" "main" {
  name                = "${lookup(var.config, "app_name")}-postgresql"
  location            = lookup(var.config, "location")
  resource_group_name = lookup(var.config, "resource_group")

  administrator_login          = lookup(var.config, "postgres_admin_name")
  administrator_login_password = lookup(var.config, "postgres_admin_password")

  sku_name   = "B_Gen5_1"
  version    = "11"
  storage_mb = 5120

  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_app_service_plan" "main" {
  name                = "${lookup(var.config, "app_name")}-app-service-plan"
  location            = lookup(var.config, "location")
  resource_group_name = lookup(var.config, "resource_group")
  kind                = "Linux"
  reserved            = true

  # See: https://azure.microsoft.com/en-us/pricing/details/app-service/linux/
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "web" {
  name                = "${lookup(var.config, "app_name")}-app-service"
  location            = lookup(var.config, "location")
  resource_group_name = lookup(var.config, "resource_group")
  app_service_plan_id = azurerm_app_service_plan.main.id

  site_config {
    # 
    linux_fx_version = "DOCKER|${lookup(var.config, "acr_name")}.azurecr.io/${lookup(var.config, "acr_name")}:latest"
    always_on        = "true"
  }

  app_settings = {
    # https://github.com/Azure/azure-rest-api-specs/issues/1698
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

    # ここが間違っていると、イメージを Docker Hub からダウンロードしようとするので要注意
    DOCKER_ENABLE_CI                = "true"
    DOCKER_REGISTRY_SERVER_URL      = "https://${lookup(var.config, "acr_name")}.azurecr.io"
    DOCKER_REGISTRY_SERVER_USERNAME = lookup(var.config, "acr_user")
    DOCKER_REGISTRY_SERVER_PASSWORD = lookup(var.config, "acr_password")

    WEBSITES_PORT = 3000

    DATABASE_HOST     = azurerm_postgresql_server.main.fqdn
    DATABASE_PORT     = 5432
    DATABASE_USER     = "${azurerm_postgresql_server.main.administrator_login}@${azurerm_postgresql_server.main.fqdn}"
    DATABASE_PASSWORD = azurerm_postgresql_server.main.administrator_login_password

    RAILS_MASTER_KEY = lookup(var.config, "rails_master_key")
    RAILS_ENV        = lookup(var.config, "rails_env")
    SECRET_KEY_BASE  = lookup(var.config, "secret_key_base")
    # nginx などは立てず、 Rails で静的ファイルも返すようにする
    RAILS_SERVE_STATIC_FILES = true

    SENDGRID_USERNAME = lookup(var.config, "sendgrid_username")
    SENDGRID_PASSWORD = lookup(var.config, "sendgrid_password")
  }

  connection_string {
    name  = "Database"
    type  = "PostgreSQL"
    value = "host=${azurerm_postgresql_server.main.fqdn}; dbname=${lookup(var.config, "db_name")} user=${azurerm_postgresql_server.main.administrator_login}@${azurerm_postgresql_server.main.fqdn} password=${azurerm_postgresql_server.main.administrator_login_password} port=5432 sslmode=require"
  }
}
