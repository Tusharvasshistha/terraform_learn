terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.70.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true
  features {
  }
}

module "aks" {
  source = "./modules/aks"
  for_each = {
    for key, value in var.servers : key => value
    if value.create_resource == true
  }
  cluster_name            = each.value.cluster_name
  cluster_location        = each.value.cluster_location
  kubernetes_version      = each.value.kubernetes_version
  private_cluster_enabled = each.value.private_cluster_enabled
  vnet_rg_name            = each.value.vnet_rg_name
  virtual_network_name    = each.value.virtual_network_name
  vnet_subnet_id          = each.value.vnet_subnet_id
  system_nodepool_name    = each.value.system_nodepool_name
  vm_size                 = each.value.vm_size
  node_availability_zones = each.value.node_availability_zones
  enable_auto_scaling     = each.value.enable_auto_scaling
  enable_node_public_ip   = each.value.enable_node_public_ip
  os_disk_size_gb         = 30
  node_min_count          = 1
  node_max_count          = 10
  node_max_pods           = 70
  VirtualMachineScaleSets = "VirtualMachineScaleSets"
  os_disk_type            = "Ephemeral"
  kubelet_disk_type       = "OS"
  os_sku                  = "Ubuntu"
  enable_rbac             = true
  enable_aad_auth         = true
  #Assigned                = each.value.Assigned
  acr_scope = each.value.acr_scope
}