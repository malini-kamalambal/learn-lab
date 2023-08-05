variable "resource_group_name" {
  description = "Name of the Azure Resource Group to use"
  type        = string
}

variable "location" {
  description = "Location of Azure Resources"
  type        = string
  default     = "eastus"
}

variable "azure_subscription_id" {
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

