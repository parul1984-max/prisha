terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.26.0"
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
