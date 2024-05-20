## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_private_dns_zone.vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |
| [azurerm_subnet.app_service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_delegated_subnet"></a> [app\_service\_delegated\_subnet](#input\_app\_service\_delegated\_subnet) | Configuration for the App Service delegated subnet. | <pre>object({<br>    name           = string<br>    address_prefix = string<br>  })</pre> | n/a | yes |
| <a name="input_app_service_plan"></a> [app\_service\_plan](#input\_app\_service\_plan) | Configuration for the app service plan. | <pre>object({<br>    name = string<br>    sku  = string<br>  })</pre> | n/a | yes |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | Configuration for the key vault. | <pre>object({<br>    name                  = string<br>    sku                   = string<br>    private_endpoint_name = string<br>    dns_zone_name         = optional(string, "privatelink.vaultcore.azure.net")<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the resources. | `string` | n/a | yes |
| <a name="input_private_endpoint_subnet"></a> [private\_endpoint\_subnet](#input\_private\_endpoint\_subnet) | Configuration for the private endpoint subnet. | <pre>object({<br>    name           = string<br>    address_prefix = string<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | Configuration for the virtual network. | <pre>object({<br>    name          = string<br>    address_space = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_web_app"></a> [web\_app](#input\_web\_app) | Configuration for the web app. | <pre>object({<br>    name                = string<br>    docker_image_name   = string<br>    docker_registry_url = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_plan_id"></a> [app\_service\_plan\_id](#output\_app\_service\_plan\_id) | The ID of the app service plan. |
| <a name="output_app_service_subnet_id"></a> [app\_service\_subnet\_id](#output\_app\_service\_subnet\_id) | The ID of the app service subnet. |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the key vault. |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | The URI of the key vault. |
| <a name="output_private_dns_zone_vault_id"></a> [private\_dns\_zone\_vault\_id](#output\_private\_dns\_zone\_vault\_id) | The ID of the private DNS zone for the vault. |
| <a name="output_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#output\_private\_endpoint\_subnet\_id) | The ID of the private endpoint subnet. |
| <a name="output_private_endpoint_vault_id"></a> [private\_endpoint\_vault\_id](#output\_private\_endpoint\_vault\_id) | The ID of the private endpoint for the vault. |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | The ID of the resource group. |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | The ID of the virtual network. |
| <a name="output_web_app_hostname"></a> [web\_app\_hostname](#output\_web\_app\_hostname) | The hostname of the web app. |
| <a name="output_web_app_id"></a> [web\_app\_id](#output\_web\_app\_id) | The ID of the web app. |
