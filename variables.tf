### General ###
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Location of the resources."
}

### Network ###
variable "virtual_network" {
  type = object({
    name          = string
    address_space = list(string)
  })
  description = "Configuration for the virtual network."
  validation {
    condition     = alltrue([for cidr in var.virtual_network.address_space : can(cidrhost(cidr, 0))])
    error_message = "The address space must be a valid IPv4 CIDR."
  }
}

variable "private_endpoint_subnet" {
  type = object({
    name           = string
    address_prefix = string
  })
  description = "Configuration for the private endpoint subnet."
  validation {
    condition     = can(cidrhost(var.private_endpoint_subnet.address_prefix, 0))
    error_message = "The address prefix must be a valid IPv4 CIDR."
  }
}

variable "app_service_delegated_subnet" {
  type = object({
    name           = string
    address_prefix = string
  })
  description = "Configuration for the App Service delegated subnet."
  validation {
    condition     = can(cidrhost(var.app_service_delegated_subnet.address_prefix, 0))
    error_message = "The address prefix must be a valid IPv4 CIDR."
  }
}

### Key Vault ###
variable "key_vault" {
  type = object({
    name                  = string
    sku                   = string
    private_endpoint_name = string
    dns_zone_name         = optional(string, "privatelink.vaultcore.azure.net")
  })
  description = "Configuration for the key vault."
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{3,22}[a-zA-Z0-9]$", var.key_vault.name))
    error_message = "The name must be between 3 and 24 characters long and can only contain alphanumeric characters and hyphens; start with a letter and end with a letter or number."
  }
  validation {
    condition     = contains(["standard", "premium"], var.key_vault.sku)
    error_message = "The sku name must be either `standard` or `premium`."
  }
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,62}[a-zA-Z0-9_]$", var.key_vault.private_endpoint_name))
    error_message = "The private endpoint name must be between 2 and 64 characters long and can only contain alphanumeric characters, hyphens, and underscores; start with an alphanumeric character and end with an alphanumeric character or underscore."
  }
}

### App Service ###
variable "app_service_plan" {
  type = object({
    name = string
    sku  = string
  })
  description = "Configuration for the app service plan."
  validation {
    condition     = contains(["S1", "S2", "S3", "P1v2", "P2v2", "P3v2", "P0v3", "P1v3", "P2v3", "P3v3"], var.app_service_plan.sku)
    error_message = "The sku name must be one of the following: S1, S2, S3, P1v2, P2v2, P3v2, P0v3, P1v3, P2v3, P3v3."
  }
}

variable "web_app" {
  type = object({
    name                = string
    docker_image_name   = string
    docker_registry_url = string
  })
  description = "Configuration for the web app."
}
