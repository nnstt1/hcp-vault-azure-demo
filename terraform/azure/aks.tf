resource "azurerm_kubernetes_cluster" "aks" {
  name                       = "aks-${local.project}"
  location                   = local.location
  resource_group_name        = azurerm_resource_group.rg.name
  dns_prefix                 = local.project
  enable_pod_security_policy = false
  local_account_disabled     = false
  private_cluster_enabled    = false

  default_node_pool {
    name           = "nodepool1"
    node_count     = 1
    vm_size        = "Standard_B2ms"
    vnet_subnet_id = azurerm_subnet.subnet_aks.id
  }

  network_profile {
    network_plugin     = "azure"
    service_cidr       = "10.0.0.0/16"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip     = "10.0.0.10"
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = file(local.ssh_key_path)
    }
  }
}
