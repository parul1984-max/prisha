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

variable "client_id" {
  description = "e868bc66-ba31-406f-aa7d-03b7ffdd6057"
  type        = string
}

variable "client_secret" {
  description = "wE98Q~qc5Kjo8wuvaT1.GqSgt4MboTycnJR_fbOG"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "c16e3359-81cc-4ad2-bbb9-6303cb0f5d7b"
  type        = string
}

variable "subscription_id" {
  description = "86815781-5d28-4bf2-bcbf-9bfc4b0dd964"
  type        = string
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
