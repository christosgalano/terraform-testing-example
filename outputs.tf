### General ###
output "resource_group_id" {
  value       = azurerm_resource_group.this.id
  description = "The ID of the resource group."
}

### Network ###
output "virtual_network_id" {
  value       = azurerm_virtual_network.this.id
  description = "The ID of the virtual network."
}

output "private_endpoint_subnet_id" {
  value       = azurerm_subnet.private_endpoint.id
  description = "The ID of the private endpoint subnet."
}

output "app_service_subnet_id" {
  value       = azurerm_subnet.app_service.id
  description = "The ID of the app service subnet."
}

### Key Vault ###
output "key_vault_id" {
  value       = azurerm_key_vault.this.id
  description = "The ID of the key vault."
}

output "key_vault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the key vault."
}

output "private_dns_zone_vault_id" {
  value       = azurerm_private_dns_zone.vault.id
  description = "The ID of the private DNS zone for the vault."
}

output "private_endpoint_vault_id" {
  value       = azurerm_private_endpoint.vault.id
  description = "The ID of the private endpoint for the vault."
}

### App Service ###
output "app_service_plan_id" {
  value       = azurerm_service_plan.this.id
  description = "The ID of the app service plan."
}

output "web_app_id" {
  value       = azurerm_linux_web_app.this.id
  description = "The ID of the web app."
}

output "web_app_hostname" {
  value       = azurerm_linux_web_app.this.default_hostname
  description = "The hostname of the web app."
}
