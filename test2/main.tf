terraform {

  required_version = " >= 0.14 "

  required_providers {

    azurerm = {

      source  = "hashicorp/azurerm"
      version = " = 3.24.0"

    }

  }
}

provider "azurerm" {

  features {

  }

}

resource "azurerm_resource_group" "tfexample" {

  name     = "my-terraform-rg"
  location = "West Europe"
}


resource "azurerm_virtual_network" "tfexample" {

  name                = "my-terraform-vnet"
  location            = azurerm_resource_group.tfexample.location
  resource_group_name = azurerm_resource_group.tfexample.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "my-terraform-env"
  }

}