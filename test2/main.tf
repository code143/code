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
# Create a Subnet in the Virtual Network
resource "azurerm_subnet" "tfexample" {
  name                 = "my-terraform-subnet"
  resource_group_name  = azurerm_resource_group.tfexample.name
  virtual_network_name = azurerm_virtual_network.tfexample.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a Network Interface
resource "azurerm_network_interface" "tfexample" {
  name                = "my-terraform-nic"
  location            = azurerm_resource_group.tfexample.location
  resource_group_name = azurerm_resource_group.tfexample.name

  ip_configuration {
    name                          = "my-terraform-nic-ip-config"
    subnet_id                     = azurerm_subnet.tfexample.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "my-terraform-env"
  }
}
