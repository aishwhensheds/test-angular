resource "azurerm_application_insights" "application_insights" {
  name                = "${var.application_name}-ain"
  location            = var.location
  resource_group_name = var.resource_group
  application_type    = "Node.JS"
}

resource "azurerm_management_lock" "ain_lock" {
  count      = var.isProd ? 1 : 0
  name       = "${var.application_name}-ain-lock"
  scope      = azurerm_application_insights.application_insights.id
  lock_level = "CanNotDelete"
}

