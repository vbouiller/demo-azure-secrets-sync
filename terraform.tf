terraform {

  cloud {
    hostname     = "app.terraform.io"
    organization = "<YOUR_ORG_NAME>"

    workspaces {
      project = "<YOUR_PROJECT>"
      name    = "<YOUR_WORKSPACE_NAME>"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.98.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }

  }
}

provider "azurerm" {
  features {}
}

provider "vault" {
  address   = var.vault_address
  namespace = var.vault_ns
  token     = var.vault_token
}

provider "random" {}