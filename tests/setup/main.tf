terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

resource "random_uuid" "tenant_id" {}

resource "random_pet" "name" {
  length = 1
}

output "name" {
  value       = random_pet.name.id
  description = "The randomly generated name."
}

output "tenant_id" {
  value       = random_uuid.tenant_id.result
  description = "The randomly generated tenant ID."
}
