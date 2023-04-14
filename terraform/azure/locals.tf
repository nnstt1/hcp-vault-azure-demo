locals {
  project  = "hcp-vault-azure-demo"
  location = "japaneast"

  vnet_address_space          = ["172.16.0.0/16"]
  subnet_aks_address_prefixes = ["172.16.1.0/24"]

  ssh_key_path = "~/.ssh/id_rsa.pub"
}