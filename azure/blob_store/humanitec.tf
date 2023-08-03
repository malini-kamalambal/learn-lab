variable "humanitec_organization" {}
variable "humanitec_token" {}
variable "region" {}
variable "access_key" {}
variable "secret_key" {}
variable "assume_role_arn" {}
variable "app_name" {}

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

resource "humanitec_resource_definition" "aws_terraform_resource_s3_bucket" {
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
        client_id = var.ARM_CLIENT_ID
        client_secret = var.ARM_CLIENT_SECRET
        azure_subscription_id = var.ARM_SUBSCRIPTION_ID
        tenant_id = var.ARM_TENANT_ID
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
          location            = var.region,
          resource_group_name = var.resource_group_name,
        }
      )
    }
  }

}
