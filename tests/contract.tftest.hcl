### Providers ###
mock_provider "azurerm" {
  mock_data "azurerm_client_config" {
    defaults = {
      tenant_id = "123e4567-e89b-12d3-a456-426614174000"
    }
  }
}

### Variables ###
variables {
  location            = "northeurope"
  resource_group_name = "rg-tftest"

  virtual_network = {
    name          = "vnet-tftest"
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
    name                  = "kv-tftest"
    sku                   = "standard"
    private_endpoint_name = "pep-kv-tftest"
  }

  app_service_plan = {
    name = "asp-tftest"
    sku  = "P1v3"
  }
  web_app = {
    name                = "app-tftest"
    docker_image_name   = "nginx"
    docker_registry_url = "https://docker.io"
  }
}

### Tests ###
run "valid_inputs" {
  command = plan
}

run "invalid_network" {
  command = plan

  variables {
    virtual_network = {
      name          = "vnet-tftest"
      address_space = ["x.x.x.x/16"]
    }
    private_endpoint_subnet = {
      name           = "snet-private-endpoint"
      address_prefix = "x.x.x.x/24"
    }
    app_service_delegated_subnet = {
      name           = "snet-app-service"
      address_prefix = "x.x.x.x/24"
    }
  }

  expect_failures = [
    var.virtual_network.address_space,
    var.private_endpoint_subnet.address_prefix,
    var.app_service_delegated_subnet.address_prefix
  ]
}


run "invalid_key_vault" {
  command = plan

  variables {
    key_vault = {
      name                  = "kv-@tftest"
      sku                   = "invalid"
      private_endpoint_name = "-pep-kv-tftest"
    }
  }

  expect_failures = [
    var.key_vault
  ]
}

run "invalid_app_service_plan" {
  command = plan

  variables {
    app_service_plan = {
      name = "asp-tftest"
      sku  = "B1"
    }
  }

  expect_failures = [
    var.app_service_plan
  ]
}
