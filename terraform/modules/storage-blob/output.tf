
output "azurerm_storage_front_account_name" {
  value       = trimsuffix(azurerm_storage_account.storage-blob-front.primary_web_endpoint, "/")
  description = "The Azure Blob storage account name."
}
