resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.project}"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = local.vnet_address_space
}

