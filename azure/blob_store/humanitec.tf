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
          storage_acccount_name = "pov-011-storageacc-$${context.app.id}-$${context.env.id}",
          container_name = "pov-011-container-$${context.app.id}-$${context.env.id}"
        }
      )
    }
  }

}
