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
variable "principal_id" {
  description = "Azure AD Object ID of the principal"
  type        = string
}

# Role Assignment
resource "azurerm_role_assignment" "blob_contributor" {
  scope                = azurerm_storage_account.storage_account./subscriptions/86815781-5d28-4bf2-bcbf-9bfc4b0dd964/resourceGroups/parul/providers/Microsoft.Storage/storageAccounts/prisha123
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.principal_id
}

