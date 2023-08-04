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
