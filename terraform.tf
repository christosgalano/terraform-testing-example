terraform {
  required_version = ">= 1.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-christos-galanopoulos"
    storage_account_name = "stterraformstategalano"
    container_name       = "terraform-testing-example"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
