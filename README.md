# Vault Secrets Sync demo with Azure Key Vault

This repository contains Terraform code to demonstrate Vault's 1.16+ Secrets Sync feature with Azure Key Vault.

## Pre-requisites

- A Vault cluster v1.16+ already deployed, and a token
- An Azure subscription account with enough rights to see the secrets in the Key Vault
- An Azure application with [enough rights](https://developer.hashicorp.com/vault/docs/sync/azurekv#permissions) to create and administrate an Azure Key Vault. You can also refer to this [Azure documentation](https://learn.microsoft.com/en-us/azure/key-vault/general/rbac-guide?tabs=azure-cli#azure-built-in-roles-for-key-vault-data-plane-operations). As well as the authentication tokens for this [Azure Service Principal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal) to be used by the azurerm provider, set as environment variables `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`
- A (free) [Terraform Cloud account](https://app.terraform.io/signup/account) to safely store the variables and the statefile

## Terraform & environment variables needed

| Key | Optional | Description | Default value |
| - | :- | :- | :- |
| **Terraform variables**
| vault_address | Required | Vault server URL | N/A |
| vault_token | Required | Vault token for Terraform | N/A |
| secret_mount_sync | Required | Vault's mount of the KV secret to be synced | N/A |
| secret_name_sync | Required | Vault's name of the KV secret to be synced | N/A |
| client_secret | Required | \[Sensitive\] client_secret of Azure's Service Principal for Vault |
| prefix | Optional | Prefix of resources names | hashicorp |
| resource_group_location | Optional | Azure datacenter location for the resource group | francecentral |
| vault_ns | Optional | Vault's namespace to use -  should be `admin` if using HCP Vault | root |
| vault_sync_destination_name | Optional | Name given to the destination set in Vault Secrets Sync | akv |
| **Environment variables**
| ARM_CLIENT_ID | Required | Azure Service Principal client_id | N/A |
| ARM_CLIENT_SECRET | Required | \[Sensitive\] Azure Service Principal client_secret | N/A |
| ARM_TENANT_ID | Required | Azure Service Principal tenant_id | N/A |
| ARM_SUBSCRIPTION_ID | Required | Azure Service Principal subscription_id | N/A |

## Demo set-up

> Before starting, make sure you have all pre-requisites as stated above!

Below are the steps needed to set-up the demo environment using the VCS or the CLI workflow:

### VCS workflow
1. Clone the repository on your Github or Gitlab account
2. Login to TFC, create a new workspace, select "Version Control Workflow"
3. Follow the instructions on TFC to connect your VCS if it's not yet done
4. Then, choose your repository, verify the settings and click on Create
5. Follow the instructions on TFC to fill in your variables

### Terraform CLI workflow
1. Clone the repository on your machine
2. Create a new git branch for your own code
3. Fill in lines 4 to 9 in `terraform.tf` to configure the Terraform Cloud block with:
  - The TFC hostname, usually app.terraform.io
  - The TFC organisation name
  - The project and workspace name
4. Update or comment out lines 23-37 if there's already a KV secret in your Vault or if you want to change the value of the secret
5. Run a `terraform fmt` to make sure your code is well formatted
6. Run `terraform login` to log in to TFC
7. Run `terraform init` to initialise your workspace
8. Access your TFC workspace and set all your variables: make sure to set your Azure tokens as `environment variables` and the others variables as `terraform variables`. Set your `ARM_CLIENT_SECRET` env variable and your `client_secret` terraform variable as sensitive 
9. Run `terraform validate` to make sure your configuration is valid

## Demo

You can follow those steps to go through the demo:

- Run `terraform apply` from the CLI, or launch an apply from TFC
- While the apply is pending, show around the Terraform code needed to deploy an Azure Key Vault
- Explain that there are three main ways to configure a Secrets Sync: terraforming it as we're doing with this code, in Vault's GUI or via the CLI
- Once the apply is done, log into the Azure console and show that the Azure Key Vault have been provided and that there's a secret, show the value of this secret and compare it to the value in Vault. You can also do this via the Azure CLI if you prefer
- Change Vault's secret value, either through terraform code followed by an apply, the CLI or the GUI
- Notice that the change have been propagated to Azure Key Vault
- Delete the secret in Vault using the method you prefer, and notice it has been deleted in Azure Key Vault
- Run `terraform destroy` or launch a destroy run to take down the demo environment