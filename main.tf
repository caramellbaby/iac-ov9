terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.107.0"
    }
  }
}

variable "environment" {
  type = string
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.environment}"
  location = "westeurope"
}


resource "azurerm_storage_account" "example" {
  name                     = "st${var.environment}example"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    environment = var.environment
  }
}

