output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "web_vm_public_ip" {
  value = azurerm_public_ip.web.ip_address
}

output "web_vm_ssh_command" {
  value = "ssh ${var.admin_username}@${azurerm_public_ip.web.ip_address}"
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_database_name" {
  value = azurerm_mssql_database.main.name
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "storage_container_name" {
  value = azurerm_storage_container.data.name
}

output "log_analytics_workspace_id" {
  value = azurerm_log_analytics_workspace.main.workspace_id
}

output "active_misconfigs" {
  description = "Quick summary of which misconfig toggles are currently ON, for your catalogue/report."
  value = {
    # Original six
    storage_public_container          = var.misconfig_storage_public_container
    storage_public_network_access     = var.misconfig_storage_allow_public_network_access
    sql_allow_all_ips                 = var.misconfig_sql_allow_all_ips
    ssh_open_to_internet              = var.misconfig_ssh_open_to_internet
    vm_password_auth_enabled          = var.misconfig_vm_allow_password_auth
    storage_logging_disabled          = var.misconfig_disable_storage_logging
    # Added to reach 18
    storage_shared_key_access_enabled = var.misconfig_storage_allow_shared_key_access
    iam_owner_role_at_rg_scope        = var.misconfig_iam_owner_role_at_rg_scope
    vm_identity_over_privileged       = var.misconfig_vm_identity_over_privileged
    storage_secure_transfer_disabled  = var.misconfig_storage_disable_secure_transfer
    storage_min_tls_lowered           = var.misconfig_storage_min_tls_version
    vm_nsg_association_removed        = var.misconfig_vm_remove_nsg_association
    nsg_allow_any_any                 = var.misconfig_nsg_allow_any_any
    sql_logging_disabled              = var.misconfig_disable_sql_logging
    log_retention_shortened           = var.misconfig_short_log_retention
    storage_cors_allow_all            = var.misconfig_storage_cors_allow_all
  }
}
