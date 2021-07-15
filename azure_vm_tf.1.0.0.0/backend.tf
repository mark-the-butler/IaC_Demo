terraform {
  backend "azurerm" {
    resource_group_name = "#{Project.Azure.RG.Name}" 
    storage_account_name = "#{Project.Azure.StorageAccount.Name}"
    container_name = "#{Project.Azure.Container.Name}"
    key = "#{Project.TF.State}"
    access_key = "#{Project.TF.State.AccessKey}"
  }
  required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">=2.61.0"
      }
  }
}