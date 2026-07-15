locals {
  name_prefix = "${var.project_name}-${var.environment}"

  resource_group_name  = "rg-${local.name_prefix}"
  vnet_name             = "vnet-${local.name_prefix}"
  web_subnet_name       = "snet-web-${local.name_prefix}"
  data_subnet_name      = "snet-data-${local.name_prefix}"
  nsg_web_name          = "nsg-web-${local.name_prefix}"
  vm_name               = "vm-web-${local.name_prefix}"
  sql_server_name       = "sql-${local.name_prefix}-${random_string.suffix.result}"
  sql_database_name     = "sqldb-${local.name_prefix}"
  storage_account_name  = lower(replace("st${var.project_name}${var.environment}${random_string.suffix.result}", "-", ""))
  law_name              = "log-${local.name_prefix}"

  tags = merge(var.tags, {
    environment = var.environment
  })
}

# Storage account + SQL server names must be globally unique across Azure,
# so we suffix them with a short random string generated once and stored in
# state (re-running terraform apply won't change it).
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}
