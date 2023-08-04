output "container" {
  value = azurerm_storage_container.pov-011.name
}
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.2"
      # configuration_aliases = [azurerm.some_name]
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  alias = "some_name"
  features {}
  subscription_id   =  var.azure_subscription_id
  tenant_id         =  var.azure_subscription_tenant_id
  client_id         =  var.service_principal_appid
  client_secret     =  var.service_principal_password
}

resource "azurerm_resource_group" "pov-011" {
  provider = azurerm.some_name
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "pov-011" {
  provider = azurerm.some_name
  name                     = "pov011storacc"
  resource_group_name      = azurerm_resource_group.pov-011.name
  location                 = azurerm_resource_group.pov-011.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# resource "random_string" "random_suffix" {
#   length  = 3
#   special = false
#   upper   = false
# }

resource "azurerm_storage_container" "pov-011" {
  provider = azurerm.some_name
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