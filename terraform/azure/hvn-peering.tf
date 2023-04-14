# HashiCorp Cloud Platform から転記してください。

locals {
  application_id = "00000000-0000-0000-0000-000000000000"
  role_def_name  = join("-", ["hcp-hvn-peering-access", local.application_id])
  vnet_id        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/hcp-vault-azure-demo/providers/Microsoft.Network/virtualNetworks/vnet-hcp-vault-azure-demo"
}

resource "azuread_service_principal" "principal" {
  application_id = local.application_id
}

resource "azurerm_role_definition" "definition" {
  name  = local.role_def_name
  scope = local.vnet_id

  assignable_scopes = [
    local.vnet_id
  ]

  permissions {
    actions = [
      "Microsoft.Network/virtualNetworks/peer/action",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/read",
      "Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write"
    ]
  }
}

resource "azurerm_role_assignment" "role_assignment" {
  principal_id       = azuread_service_principal.principal.id
  role_definition_id = azurerm_role_definition.definition.role_definition_resource_id
  scope              = local.vnet_id
}
