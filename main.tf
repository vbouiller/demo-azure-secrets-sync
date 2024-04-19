resource "random_pet" "random_name" {
  prefix = var.prefix
  length = 2
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${random_pet.random_name.id}"
  location = var.resource_group_location
}

resource "azurerm_key_vault" "akv" {
  name                = "akv-${random_pet.random_name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name                  = "standard"
  enable_rbac_authorization = true
}

resource "vault_mount" "kvv2" {
  path    = var.secret_mount_sync
  type    = "kv"
  options = { version = "2" }
}

resource "vault_kv_secret_v2" "apikey" {
  mount = vault_mount.kvv2.path
  name  = var.secret_name_sync
  data_json = jsonencode(
    {
      key = "c5fa7be67c8b09774b42b235"
    }
  )
}

resource "vault_secrets_sync_azure_destination" "az" {
  name          = var.vault_sync_destination_name
  key_vault_uri = azurerm_key_vault.akv.vault_uri

  client_id     = data.azurerm_client_config.current.client_id
  client_secret = var.client_secret
  tenant_id     = data.azurerm_client_config.current.tenant_id
}

resource "vault_secrets_sync_association" "billingapp_apikey" {
  name        = vault_secrets_sync_azure_destination.az.name
  type        = vault_secrets_sync_azure_destination.az.type
  mount       = var.secret_mount_sync
  secret_name = var.secret_name_sync
}
