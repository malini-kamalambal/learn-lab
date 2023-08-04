output "container" {
  value = azurerm_storage_container.pov-011.name
}

output "nice_message" {
  value = "How Do Do"
}


# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.67.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  subscription_id   =  var.azure_subscription_id
  tenant_id         =  var.azure_subscription_tenant_id
  client_id         =  var.service_principal_appid
  client_secret     =  var.service_principal_password
}

resource "azurerm_resource_group" "pov-011" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "pov-011" {
  name                     = "pov011storacc"
  resource_group_name      = azurerm_resource_group.pov-011.name
  location                 = azurerm_resource_group.pov-011.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "pov-011" {
  name                  = "pov011content-b"
  storage_account_name  = azurerm_storage_account.pov-011.name
  container_access_type = "private"
}

# resource "azurerm_storage_blob" "example" {
#   name                   = "my-awesome-content.zip"
#   storage_account_name   = azurerm_storage_account.example.name
#   storage_container_name = azurerm_storage_container.example.name
#   type                   = "Block"
#   source                 = "some-local-file.zip"
# }
