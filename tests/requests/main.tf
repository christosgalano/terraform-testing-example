terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}

variable "endpoints" {
  type        = list(string)
  description = "List of endpoints to test."
}

data "http" "requests" {
  count  = length(var.endpoints)
  url    = var.endpoints[count.index]
  method = "GET"
}
