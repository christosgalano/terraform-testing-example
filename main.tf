### General ###
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

### Network ###
resource "azurerm_virtual_network" "this" {
  name                = var.virtual_network.name
  address_space       = var.virtual_network.address_space
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "private_endpoint" {
  name                 = var.private_endpoint_subnet.name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.private_endpoint_subnet.address_prefix]
}

resource "azurerm_subnet" "app_service" {
  name                 = var.app_service_delegated_subnet.name
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [var.app_service_delegated_subnet.address_prefix]
  delegation {
    name = "sf"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

### Key Vault ###
resource "azurerm_key_vault" "this" {
  name                          = var.key_vault.name
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  sku_name                      = var.key_vault.sku
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = false
  purge_protection_enabled      = false
}

resource "azurerm_private_dns_zone" "vault" {
  name                = var.key_vault.dns_zone_name
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vault" {
  name                  = "key-vault-vnet-link"
  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_name = azurerm_private_dns_zone.vault.name
  virtual_network_id    = azurerm_virtual_network.this.id
}

resource "azurerm_private_endpoint" "vault" {
  name                = var.key_vault.private_endpoint_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  subnet_id           = azurerm_subnet.private_endpoint.id
  private_service_connection {
    name                           = "key-vault-connection"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
}

### App Service ###
resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = var.app_service_plan.sku
}

resource "azurerm_linux_web_app" "this" {
  name                      = var.web_app.name
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_service_plan.this.location
  service_plan_id           = azurerm_service_plan.this.id
  virtual_network_subnet_id = azurerm_subnet.app_service.id
  https_only                = true
  site_config {
    always_on              = true
    vnet_route_all_enabled = true
    application_stack {
      docker_image_name   = var.web_app.docker_image_name
      docker_registry_url = var.web_app.docker_registry_url
    }
  }
}
