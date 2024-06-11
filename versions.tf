terraform {
  required_version = ">= 1.0.8"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.38.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.54.0"
    }
    rad-security = {
      source  = "rad-security/rad-security"
      version = ">= 1.0.3"
    }
  }
}
