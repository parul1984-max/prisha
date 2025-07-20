terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }

}

provider "azurerm" {
 features {}
 subscription_id = "86815781-5d28-4bf2-bcbf-9bfc4b0dd964"
}

resource "azurerm_resource_group" "rg_w" {
  name     = "parul"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "prisha123"
  resource_group_name      = "parul"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_network" "Virtual_network" {
  name                = "VNET_PRISHA"
  resource_group_name = "parul"
  location            = "West Europe"
  address_space       = ["10.1.0.0/28"]
}
