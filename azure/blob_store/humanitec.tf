variable "humanitec_organization" {}
variable "humanitec_token" {}
variable "location" {}
variable "app_name" {}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "azure_subscription_tenant_id" {
  description = "Azure Subscription Tenant ID"
  type        = string
}

variable "service_principal_appid" {
  description = "Azure Service Principal App ID"
  type        = string
}

variable "service_principal_password" {
  description = "Azure Service Principal Password"
  type        = string
}

terraform {
  required_providers {
    humanitec = {
      source = "humanitec/humanitec"
    }
  }
}

provider "humanitec" {
  org_id = var.humanitec_organization
  token  = var.humanitec_token
}


resource "humanitec_application" "app" {
  id   = var.app_name
  name = var.app_name
}

resource "humanitec_resource_definition" "azure_terraform_resource_container" {
  driver_type = "${var.humanitec_organization}/terraform"
  id          = "${var.app_name}-azure-blob-store"
  name        = "${var.app_name}-azure-blob-store"
  type        = "s3"

  criteria = [
    {
      app_id = humanitec_application.app.id
    }
  ]

  driver_inputs = {
    secrets = {
      variables = jsonencode({
        # access_key = var.access_key
        # secret_key = var.secret_key
        service_principal_appid = var.service_principal_appid
        service_principal_password = var.service_principal_password
        azure_subscription_id = var.subscription_id
        azure_subscription_tenant_id = var.azure_subscription_tenant_id
      })
    },

    values = {
      "source" = jsonencode(
        {
          path = "azure/terraform/blob_store/"
          rev  = "refs/heads/main"
          url  = "https://github.com/malini-kamalambal/learn-lab.git"
        }
      )
      "variables" = jsonencode(
        {
          location            = var.location,
          resource_group_name = var.resource_group_name,
        }
      )
    }
  }

}
