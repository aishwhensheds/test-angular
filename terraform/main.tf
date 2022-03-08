terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.91"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

locals {
  // If an environment is set up (dev, test, prod...), it is used in the application name
  environment = var.environment == "" ? "dev" : var.environment
  isProd      = var.isProd == "True" || var.isProd == "true"
}

resource "azurerm_resource_group" "main" {
  name     = "${var.application_name}-${local.environment}"
  location = var.location
}

resource "azurerm_management_lock" "rg_lock" {
  count      = local.isProd ? 1 : 0
  name       = "${var.application_name}-${local.environment}-lock"
  scope      = azurerm_resource_group.main.id
  lock_level = "CanNotDelete"
}

module "storage-blob-front" {
  source           = "./modules/storage-blob"
  resource_group   = azurerm_resource_group.main.name
  application_name = "${var.application_name}-${local.environment}"
  environment      = local.environment
  location         = var.location
}

# module "application-insights" {
#   source           = "./modules/application-insights"
#   resource_group   = azurerm_resource_group.main.name
#   application_name = "${var.application_name}-${local.environment}"
#   environment      = local.environment
#   location         = var.location
# }
