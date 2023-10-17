data "azurerm_subnet" "subnet" {
  name                 = var.vnet_subnet_id
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.vnet_rg_name
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.cluster_name
  location = var.cluster_location
}

resource "azurerm_user_assigned_identity" "ai" {
  count               = var.Assigned == "UserAssigned" ? 1 : 0
  location            = var.cluster_location
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "dns-${var.cluster_name}"
  kubernetes_version  = var.kubernetes_version

  tags = {
    budget   = ""
    customer = "sbxuat"
    environment : "shr-nprd"
    high-availability : "local"
    product-name : "hub-foundation"
  }

  private_cluster_enabled = var.private_cluster_enabled

  default_node_pool {
    name                  = var.system_nodepool_name 
    vm_size               = var.vm_size              
    zones                 = var.node_availability_zones
    type                  = var.VirtualMachineScaleSets
    max_pods              = var.node_max_pods
    os_disk_size_gb       = var.os_disk_size_gb
    vnet_subnet_id        = data.azurerm_subnet.subnet.id
    enable_auto_scaling   = var.enable_auto_scaling
    min_count             = var.node_min_count
    max_count             = var.node_max_count
    enable_node_public_ip = var.enable_node_public_ip
    os_disk_type      = var.os_disk_type
    kubelet_disk_type = var.kubelet_disk_type
    os_sku            = var.os_sku
  }

  role_based_access_control_enabled = var.enable_rbac

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.enable_aad_auth == false ? [] : [1]
    content {
      tenant_id          = "a4d7b2eb-3a11-46db-95bf-be08b76d457b"
      managed            = true
      azure_rbac_enabled = true
    }
  }

    identity {
    type         = var.Assigned
    identity_ids = var.Assigned ==  "UserAssigned" ? tolist([azurerm_user_assigned_identity.ai[0].id]) : null
    #depends_on = [ azurerm_user_assigned_identity.ai ]
  }

  # dynamic identity {
  #   for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned" ? [var.identity_type] : []
  #   content {
  #     type = var.identity_type
  #   }
  # }

  # dynamic identity {
  #   for_each = length(var.identity_ids) > 0 || var.identity_type == "UserAssigned" ? [var.identity_type] : []
  #   content {
  #     type         = var.identity_type
  #     identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
  #   }
  # }

  sku_tier = "Standard"
  network_profile {
    network_plugin    = "kubenet"
    network_policy    = "calico"
    load_balancer_sku = "standard"
  }

  workload_identity_enabled = true
  oidc_issuer_enabled = true

  key_vault_secrets_provider {
    secret_rotation_enabled = true
    secret_rotation_interval = "2m"
  }
  lifecycle {
    ignore_changes = [ # Ignore changes to tags, as this is managed by the tagger
      tags,
    ]
  }
  automatic_channel_upgrade = "patch"
}

resource "azurerm_role_assignment" "kubweb_to_acr" {
  scope                = var.acr_scope
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  depends_on = [ azurerm_kubernetes_cluster.k8s ]
}