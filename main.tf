provider "azurerm" {
  features {}
  subscription_id = "28482e9d-5eba-49a8-a6ec-597400f6829c"
}

resource "azurerm_resource_group" "main" {
  name     = "advisor-crm-rg"
  location = "West Europe"
}

resource "azurerm_mssql_server" "main" {
  name                         = "advisorcrm-sqlserver"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "advisorsync"
  administrator_login_password = var.sql_password
}

resource "azurerm_mssql_database" "main" {
  name           = "advisorcrmdb"
  server_id      = azurerm_mssql_server.main.id
  sku_name       = "Basic"
  max_size_gb    = 2
  zone_redundant = false
}

resource "azurerm_mssql_firewall_rule" "allow_all" {
  name             = "AllowAll"
  server_id        = azurerm_mssql_server.main.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

resource "null_resource" "run_sql_schema" {
  depends_on = [azurerm_mssql_database.main, azurerm_mssql_firewall_rule.allow_all]

  provisioner "local-exec" {
    command = "sqlcmd -S ${azurerm_mssql_server.main.fully_qualified_domain_name} -U sqladminuser -P ${var.sql_password} -d advisorcrmdb -i azure_sql_schema.sql"
  }
}

variable "sql_password" {
  description = "SQL Server admin password"
  type        = string
  default = "SqlSync123!"
}