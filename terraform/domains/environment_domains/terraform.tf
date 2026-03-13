terraform {

  required_version = "= 1.14.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.61.0"
    }
    statuscake = {
      source  = "StatusCakeDev/statuscake"
      version = "2.2.2"
    }
  }
  backend "azurerm" {
    container_name = "terraform-state"
  }
}

provider "azurerm" {
  features {}

  resource_provider_registrations = "none"
}

provider "statuscake" {
  api_token = module.infrastructure_secrets.map.STATUSCAKE-API-TOKEN
}
