resource "azurerm_resource_group" "rg" {
  location = local.location
  name     = local.project
}
