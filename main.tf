terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  cloud {
    organization = "ClenkasoftDevPoc"
    workspaces {
      name = "DeployToAzureLabs"
    }
  }

}


provider "azurerm" {
  features {}
}

