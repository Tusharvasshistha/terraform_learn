#cluster information
variable "cluster_name" {
  type = string
  #default = "rg-sbxuat-shr-nprd-aks"
  description = "Name of the AKS cluster"
}

variable "cluster_location" {
  type = string
  #default = "uksouth"
  description = "Name of the AKS cluster Location"
}

variable "kubernetes_version" {
  type = string
  #default = "1.26.3"
}

#private cluster enabled or not
variable "private_cluster_enabled" {
  type = bool
  #default = true
  description = "value for private_cluster_enabled"
}

#vnet details for cluster

variable "vnet_rg_name" {
  type = string
  #default = "rg-sbxuat-shr-nprd-net"
}

variable "virtual_network_name" {
  type = string
  #default = "vnet-uks1-sbxuat-shr-nprd-01"
  description = "The name of the virtual network to use"
}

variable "vnet_subnet_id" {
  type = string
  #default = "snet-uks-hub-shr-nprd-aks"
  description = "The subnet ID for default_node_pool"
}

# system nodepool details availabilty zones

variable "system_nodepool_name" {
  type = string
  #default = "npsytem"
}

variable "vm_size" {
  type = string
  #default = "Standard_D2_v2"
}

variable "node_availability_zones" {
  type = list(string)
  #default     = ["1", "2", "3"]
  description = "The availability zones to place the node pool instances"
}

variable "enable_auto_scaling" {
  #default     = true
  description = "Enable autoscaling on the default node pool"
}

variable "enable_node_public_ip" {
  #default     = false
  description = "Enable public IPs on the default node pool"
}

variable "os_disk_size_gb" {
  #default     = 50
  description = "Default node pool disk size"
}

variable "node_min_count" {
  #default     = 1
  description = "Default node pool intial count (used with autoscaling)"
}

variable "node_max_count" {
  #default     = 10
  description = "Default node pool max count (use with autoscaling)"
}

variable "node_max_pods" {
  #default     = 70
  description = "Total amount of pods allowed per node"
}

variable "VirtualMachineScaleSets" {
  #default     = "VirtualMachineScaleSets"
  description = "The type of node pool to use"
}

variable "os_disk_type" {
  #default     = "Managed"
  description = "The type of node pool to use"
}

variable "kubelet_disk_type" {
  #default     = "OS"
  description = "The type of node pool to use"
}

variable "os_sku" {
  #default = "Ubuntu"
  description = "value for os_sku"
}


#rbac and aad auth details
variable "enable_rbac" {
  #default     = true
  description = "Enable RBAC on the Kubernetes API"
}

variable "enable_aad_auth" {
  #default     = true
  description = "Enable Kubernetes API Azure AD authentication"
}

variable "Assigned" {
  type = string
  default     = "SystemAssigned"
  #description = "The secret to use for the AKS service principal account"
}

#variable "user_assigned_ids" {
 # type    = list(string)
 # default = null
#}

variable "acr_scope" {
  type = string
}


# variable "enable_http_application_routing" {
#   default = false
# }

# variable "enable_kube_dashboard" {
#   default = false
# }

# variable "enable_aci_connector_linux" {
#   default = false
# }

# variable "enable_azure_policy" {
#   default = false
# }

# variable "log_analytics_workspace_id" {
#   default     = null
#   description = "If set, this enables the OMS agent cluster addon"
# }

# variable "node_taints" {
#   default     = null
#   description = "Default node pool taints"
# }

# variable "node_type" {
#   default     = "Standard_D2_v2"
#   description = "The Azure VM instance type"
# }

# variable "docker_bridge_cidr" {
#   description = "The CIDR to use for the docker network interface"
#   default     = null
# }

# variable "managed_outbound_ip_count" {
#   default = null
#   type    = number
# }

# variable "outbound_ip_address_ids" {
#   default = null
#   type    = list(string)
# }

# variable "outbound_ip_prefix_ids" {
#   default = null
#   type    = list(string)
# }

# variable "outbound_ports_allocated" {
#   default = 0
#   type    = number
# }

# variable "load_balancer_idle_timeout_in_minutes" {
#   default = 30
#   type    = number
# }

# variable "load_balancer_sku" {
#   type        = string
#   description = "The load balancer type. Supported values: basic, standard"
#   default     = "standard"
# }

# # https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html#network_plugin
# variable "network_plugin" {
#   type        = string
#   description = "The CNI network plugin to use (only azure, or kubenet)"
#   default     = "kubenet"
# }

# # https://www.terraform.io/docs/providers/azurerm/r/kubernetes_cluster.html#network_policy
# variable "network_policy" {
#   description = "The network polcy for the CNI. Only used when network_plugin is set to azure. Supported values: calico, azure"
#   default     = null
# }

# variable "node_subnet_id" {
#   type        = string
#   description = "The subnet ID for default_node_pool"
# }

# variable "pod_cidr" {
#   description = "The CIDR for the pod network"
#   default     = null
# }

# variable "public_ssh_key" {
#   type        = string
#   description = "Public SSH key tied to the admin user in linux_profile"
# }

# variable "region" {
#   type        = string
#   description = "Azure Region"
# }

# variable "resource_group_name" {
#   type        = string
#   description = "Name of the resource group to use"
# }

# variable "service_cidr" {
#   description = "The CIDR for kubernetes services"
#   default     = null
# }

# variable "additional_tags" {
#   default = {}
# }
