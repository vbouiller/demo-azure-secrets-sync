variable "prefix" {
  description = "Prefix for resources names"
  type        = string
  default     = "hashicorp"
}

variable "resource_group_location" {
  type    = string
  default = "francecentral"
}

variable "client_secret" {
  description = "client_secret of Azure's Service Principal, see https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal"
  type        = string
  sensitive   = true
}

variable "vault_address" {
  description = "Existing Vault's cluster public URL"
  type        = string
}

variable "vault_ns" {
  description = "Vault's namespace to use"
  type        = string
  default     = "root"
}

variable "vault_token" {
  default   = "Vault's token for Terraform"
  type      = string
  sensitive = true
}

variable "vault_sync_destination_name" {
  description = "Name given to the destination set in Vault Secrets Sync"
  type        = string
  default     = "akv"
}

variable "secret_mount_sync" {
  description = "Vault's mount of the KV secret to be synced"
  type        = string
}

variable "secret_name_sync" {
  description = "Vault's name of the KV secret to be synced"
  type        = string
}