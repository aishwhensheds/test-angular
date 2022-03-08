
data "azurerm_client_config" "current" {}


resource "azurerm_storage_account" "storage-blob-front" {
  name                      = "${replace(var.application_name, "-", "")}front"
  resource_group_name       = var.resource_group
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  static_website {
    index_document = "index.html"
  }

  blob_properties {
    delete_retention_policy {
      days = "7"
    }
  }

  tags = {
    environment = var.environment,
    # sg_Resource_ControlTower_Profile         = "authenticatedPrivateBlob"
    # sg_Resource_ControlTower_Confidentiality = "C2"
  }
}

####################################
# LOCK
####################################
resource "azurerm_management_lock" "sa_front_lock" {
  count      = var.isProd ? 1 : 0
  name       = "${var.application_name}-sa-front-lock"
  scope      = azurerm_storage_account.storage-blob-front.id
  lock_level = "CanNotDelete"
}
