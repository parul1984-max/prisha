variable "client_id" {
  description = "Azure Client ID used for authentication"
  type        = string
}

variable "client_secret" {
  description = "Azure Client Secret used for authentication"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID where resources will be managed"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID to use for resource deployment"
  type        = string
}