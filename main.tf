terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.myvariable
  location = "westeurope"
}

variable "myvariable" {
  description = "Testvariabel for feil"
  type        = string
  default     = "rg_iacov9"
}
