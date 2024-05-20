location            = "northeurope"
resource_group_name = "rg-terraform-testing"

virtual_network = {
  name          = "vnet-terraform-testing"
  address_space = ["10.0.0.0/16"]
}
private_endpoint_subnet = {
  name           = "snet-private-endpoint"
  address_prefix = "10.0.0.0/24"
}
app_service_delegated_subnet = {
  name           = "snet-app-service"
  address_prefix = "10.0.2.0/24"
}

key_vault = {
  name                  = "kv-terraform-testing-01"
  sku                   = "standard"
  private_endpoint_name = "pep-kv-terraform-testing"
  tenant_id             = "9ff6cf09-458a-47ed-b9fa-d67fb086f59c"
}

app_service_plan = {
  name = "asp-terraform-testing"
  sku  = "P1v3"
}
web_app = {
  name                = "app-dwg-terraform-testing"
  docker_image_name   = "christosgalano/devops-with-github-example:a45df4bdc99f4b6b09b96dd852087fc76333b75a"
  docker_registry_url = "https://ghcr.io"
}
