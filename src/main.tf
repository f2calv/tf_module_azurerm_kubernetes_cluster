data "azurerm_resource_group" "k8s_rg" {
  name = var.k8s_resource_group_name
}

data "azurerm_kubernetes_service_versions" "current" {
  location        = data.azurerm_resource_group.k8s_rg.location
  include_preview = false
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "this" {
  lifecycle {
    ignore_changes = [
      kubernetes_version,
      default_node_pool[0].orchestrator_version,
      default_node_pool[0].node_count
    ]
  }

  location            = data.azurerm_resource_group.k8s_rg.location
  resource_group_name = var.k8s_resource_group_name
  name                = var.k8s_cluster_name
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  dns_prefix          = var.k8s_cluster_dns_prefix
  tags                = var.tags
  node_resource_group = var.k8s_node_resource_group

  automatic_upgrade_channel = var.k8s_automatic_channel_upgrade
  node_os_upgrade_channel   = var.k8s_node_os_channel_upgrade

  default_node_pool {
    name                 = var.k8s_node_pool_name
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    node_count           = var.k8s_node_count
    vm_size              = var.k8s_vm_size
    max_pods             = var.k8s_vm_max_pods
    os_disk_size_gb      = var.k8s_vm_disk_size
    vnet_subnet_id       = var.k8s_vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  node_provisioning_profile {
    mode = "Manual"
  }

  maintenance_window_auto_upgrade {
    frequency   = "Weekly"
    interval    = 1
    duration    = var.k8s_maintenance_duration_hours
    day_of_week = var.k8s_maintenance_day_of_week
    start_time  = var.k8s_maintenance_start_time
    utc_offset  = var.k8s_maintenance_utc_offset
  }

  maintenance_window_node_os {
    frequency   = "Weekly"
    interval    = 1
    duration    = var.k8s_maintenance_duration_hours
    day_of_week = var.k8s_maintenance_day_of_week
    start_time  = var.k8s_maintenance_start_time
    utc_offset  = var.k8s_maintenance_utc_offset
  }

  role_based_access_control_enabled = true
  provisioner "local-exec" {
    command = "kubectl config delete-context ${self.name}"
    when    = destroy
  }
}
