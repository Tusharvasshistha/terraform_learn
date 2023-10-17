servers = {
  "aks_test" = {
    create_resource      = true
    resource_group_name  = "rg-sbxuat-shr-nprd-aks"
    cluster_name         = "rg-sbxuat-shr-nprd-aks"
    cluster_location     = "uksouth"
    vnet_subnet_name     = "snet-uks-hub-shr-nprd-aks"
    virtual_network_name = "vnet-uks1-sbxuat-shr-nprd-01"
    vnet_rg_name         = "rg-sbxuat-shr-nprd-net"
    identity_type        = "UserAssigned"
  },
  "aks_test1" = {
    create_resource      = true
    resource_group_name  = "rg-sbxuat-shr-nprd-net"
    cluster_name         = "rg-sbxuat-shr-nprd-aks1"
    cluster_location     = "uksouth"
    vnet_subnet_name     = "snet-uks-hub-shr-nprd-aks"
    virtual_network_name = "vnet-uks1-sbxuat-shr-nprd-01"
    vnet_rg_name         = "rg-sbxuat-shr-nprd-net"
    identity_type        = "UserAssigned"
  }
}