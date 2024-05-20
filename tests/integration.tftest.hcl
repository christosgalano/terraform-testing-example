provider "azurerm" {
  features {}
}

run "setup" {
  module {
    source = "./tests/setup"
  }
}

run "create_infrastructure" {
  command = apply

  variables {
    location            = "northeurope"
    resource_group_name = "rg-tftest-${run.setup.name}"
    virtual_network = {
      name          = "vnet-tftest-${run.setup.name}"
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
      name                  = "kv-tftest-${run.setup.name}"
      sku                   = "standard"
      private_endpoint_name = "pep-kv-tftest-${run.setup.name}"
    }
    app_service_plan = {
      name = "asp-tftest-${run.setup.name}"
      sku  = "P1v3"
    }
    web_app = {
      name                = "app-tftest-${run.setup.name}"
      docker_image_name   = "christosgalano/devops-with-github-example:a45df4bdc99f4b6b09b96dd852087fc76333b75a"
      docker_registry_url = "https://ghcr.io"
    }
  }
}

run "webapp_status_and_content_verification" {
  command = plan

  module {
    source = "./tests/requests"
  }

  variables {
    endpoints = [
      "https://${run.create_infrastructure.web_app_hostname}",
      "https://${run.create_infrastructure.web_app_hostname}/health",
      "https://${run.create_infrastructure.web_app_hostname}/Bob",
      "https://${run.create_infrastructure.web_app_hostname}/Bob/Alice",
    ]
  }

  assert {
    condition     = alltrue([for req in data.http.requests : req.status_code == 200])
    error_message = "The root endpoint did not respond with HTTP status 200."
  }

  assert {
    condition     = data.http.requests[1].response_body == "\"OK\""
    error_message = "Website responded with unexpected content."
  }

  assert {
    condition     = data.http.requests[2].response_body == "\"Hello Bob\""
    error_message = "Website responded with unexpected content."
  }

  assert {
    condition     = data.http.requests[3].response_body == "\"Hello Bob, Alice\""
    error_message = "Website responded with unexpected content."
  }
}

run "key_vault_network_privacy_check" {
  command = plan

  module {
    source = "./tests/requests"
  }

  variables {
    endpoints = [run.create_infrastructure.key_vault_uri]
  }

  assert {
    condition     = data.http.requests[0].status_code == 403
    error_message = "Key Vault responded with HTTP status ${data.http.requests[0].status_code}"
  }
}
