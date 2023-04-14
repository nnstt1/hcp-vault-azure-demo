locals {
  hvn_cidr = "172.25.16.0/20"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${local.project}"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet_aks.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_rule" "nsg_rule_consul_server_inbound" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  name                        = "ConsulServerInbound"
  priority                    = 400
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "8301"
  source_address_prefix       = local.hvn_cidr
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "nsg_rule_consul_client_inbound" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  name                        = "ConsulClientInbound"
  priority                    = 401
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "8301"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "nsg_rule_consul_server_outbound" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  name                        = "ConsulServerOutbound"
  priority                    = 400
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "8300-8301"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = local.hvn_cidr
}

resource "azurerm_network_security_rule" "nsg_rule_consul_client_outbound" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  name                        = "ConsulClientOutbound"
  priority                    = 401
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "8301"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
}

resource "azurerm_network_security_rule" "nsg_rule_http_outbound" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  name                        = "HTTPOutbound"
  priority                    = 402
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = local.hvn_cidr
}

resource "azurerm_network_security_rule" "nsg_rule_https_outbound" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  name                        = "HTTPSOutbound"
  priority                    = 403
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = local.hvn_cidr
}

resource "azurerm_network_security_rule" "nsg_rule_consul_server_outbound_grpc" {
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  name                        = "ConsulServerOutboundGRPC"
  priority                    = 404
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "8502"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = local.hvn_cidr
}
