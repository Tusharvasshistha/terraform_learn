resource "random_id" "prefix" {
  byte_length = 8
}

# resource "azurerm_resource_group" "main" {
#   count    = var.create_resource_group ? 1 : 0
#   location = var.location
#   name     = coalesce(var.resource_group_name, "${random_id.prefix.hex}-rg")
# }

# locals {
#   resource_group = {
#     name     = var.create_resource_group ? azurerm_resource_group.main[0].name : var.resource_group_name
#     location = var.location
#   }
# }

#data "azurerm_subnet" "subnet" {
#name                 = var.vnet_subnet_name
#resource_group_name  = var.vnet_rg_name
#virtual_network_name = var.virtual_network_name
#}

 resource "azurerm_user_assigned_identity" "ai" {
   for_each = {
    for key, value in var.servers : key => value
    if value.create_resource == true && value.identity_type == "UserAssigned" ? true : false
  }
  #count               = each.value.identity_type == "UserAssigned" ? 1 : 0
   location            = each.value.cluster_location
   name                = each.value.cluster_name ##"${random_id.prefix.hex}-identity"
   resource_group_name = each.value.resource_group_name
 }

module "aks_cluster_name" {
  source = "../modules/aks_new"
  for_each = {
    for key, value in var.servers : key => value
    if value.create_resource == true
  }
  prefix              = "prefix"
  resource_group_name = each.value.resource_group_name
  #admin_username                  = null
  azure_policy_enabled            = true
  cluster_name                    = each.value.cluster_name
  public_network_access_enabled   = false
  identity_ids                    = each.value.identity_type == "UserAssigned" ? tolist([azurerm_user_assigned_identity.ai[each.key].id]) : null #[azurerm_user_assigned_identity.test.id]
  identity_type                   = each.value.identity_type
  log_analytics_workspace_enabled = false
  vnet_rg_name                    = each.value.vnet_rg_name
  virtual_network_name            = each.value.virtual_network_name
  vnet_subnet_name                = each.value.vnet_subnet_name
  maintenance_window = {
    allowed = [
      {
        day   = "Sunday",
        hours = [22, 23]
      },
    ]
    not_allowed = []
  }
  private_cluster_enabled = true
  #vnet_subnet_id                    = data.azurerm_subnet.subnet.id
  #vnet_rg_name            = each.value.vnet_rg_name
  #virtual_network_name    = each.value.virtual_network_name
  #vnet_subnet_name          = each.value.vnet_subnet_id
  rbac_aad                          = true
  rbac_aad_managed                  = true
  role_based_access_control_enabled = true
  enable_auto_scaling               = true
  kubernetes_version                = "1.26.3"
  depends_on = [ azurerm_user_assigned_identity.ai ]
}