#create resourse group name
variable "create_resource_group" {
  type     = bool
  default  = false
  nullable = false
}

variable "resource_group_name" {
  type    = string
  default = "rg-sbxuat-shr-nprd-aks"
}

variable "cluster_name" {
  type    = string
  default = "aks-uks1-sbxuat-shr-nprd"
}

variable "identity_type" {
  type    = string
  default = "UserAssigned"
  #default = "SystemAssigned"
}

#get subnet id
variable "vnet_subnet_name" {
  type    = string
  default = "snet-uks-hub-shr-nprd-aks"
}

variable "virtual_network_name" {
  type    = string
  default = "vnet-uks1-sbxuat-shr-nprd-01"
}

variable "vnet_rg_name" {
  type    = string
  default = "rg-sbxuat-shr-nprd-net"
}

variable "location" {
  type    = string
  default = "uksouth"
}

#cluster information
variable "servers" {
  type = map(object({
    create_resource  = bool
    cluster_name     = string
    cluster_location = string
    #kubernetes_version      = string
    #private_cluster_enabled = bool
    vnet_rg_name         = string
    virtual_network_name = string
    vnet_subnet_name     = string
    resource_group_name  = string
    identity_type        = string
    #vnet_subnet_id          = string
  }))
}