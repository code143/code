provider "azurerm" {

features {
  
}

}


resource "azurerm_resource_group" "example" {
  name = "my-terraform-rs"
  location = "west Europe"
}
