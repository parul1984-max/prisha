terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_cli = false

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
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
resource "azurerm_subnet" "subnet1" {
  name                 = "12prish_12"
  resource_group_name  = "parul"
  virtual_network_name = azurerm_virtual_network.Virtual_network.name
  address_prefixes     = ["10.1.0.0/28"]
}