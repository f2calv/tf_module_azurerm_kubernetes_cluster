#https://build5nines.com/terraform-create-an-aks-cluster/

//https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group
# resource "azuread_group" "k8s_administrators" {
#   name        = "${var.k8s_cluster_name}-administrators"
#   description = "Kubernetes administrators for the ${var.k8s_cluster_name} cluster."
# }

# #disabled ACI virtual node
# //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
# resource "azurerm_virtual_network" "k8s_vnet" {
#   name                = var.k8s_vnet_name
#   resource_group_name = var.k8s_resource_group_name
#   location            = data.azurerm_resource_group.k8s_rg.location
#   address_space       = ["10.240.0.0/16"]
#   tags                = var.tags
#   # subnet {
#   #   name           = var.k8s_vnet_subnet_name
#   #   address_prefix = "10.240.0.0/16"
#   # }
# }
# //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
# resource "azurerm_subnet" "k8s_subnet" {
#   name                 = var.k8s_vnet_subnet_name
#   resource_group_name  = var.k8s_resource_group_name
#   virtual_network_name = azurerm_virtual_network.k8s_vnet.name
#   address_prefixes     = ["10.240.1.0/24"]
#   #tags                 = var.tags #tags not valid here
# }
# //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
# resource "azurerm_role_assignment" "k8s_subnet_role" {
#   scope                = azurerm_subnet.k8s_subnet.id
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
# }
# //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
# resource "azurerm_subnet" "k8s_vk_subnet" {
#   name                 = var.k8s_vk_subnet_name
#   resource_group_name  = var.k8s_resource_group_name
#   virtual_network_name = azurerm_virtual_network.k8s_vnet.name
#   address_prefixes     = ["10.240.2.0/24"]
#   delegation {
#     name = "aciDelegation"
#     service_delegation {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#     }
#   }
#   #tags                 = var.tags #tags not valid here
# }
# //https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
# resource "azurerm_role_assignment" "k8s_vk_subnet_role" {
#   count                = 0 #disabled ACI virtual node
#   scope                = azurerm_subnet.k8s_vk_subnet.id
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
# }


//https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
//https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples/kubernetes
//https://learn.hashicorp.com/tutorials/terraform/aks
//https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider
//https://github.com/Azure/terraform-azurerm-aks
//https://github.com/neumanndaniel/terraform
//https://github.com/terraform-providers/terraform-provider-azurerm/issues/3157 (for ACI)
resource "azurerm_kubernetes_cluster" "k8s" {
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

  default_node_pool {
    name                 = var.k8s_node_pool_name
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    node_count           = var.k8s_node_count
    vm_size              = var.k8s_vm_size
    max_pods             = var.k8s_vm_max_pods
    os_disk_size_gb      = var.k8s_vm_disk_size
    #vnet_subnet_id       = azurerm_subnet.k8s_subnet.id #disabled ACI virtual node
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
  # azure_active_directory_role_based_access_control {
  #   managed                = true
  #   admin_group_object_ids = [azuread_group.k8s_administrators.object_id]
  # }

  #azure_policy_enabled = var.addons.azure_policy
  #http_application_routing_enabled = true
  # #disabled ACI virtual node
  # aci_connector_linux {
  #   subnet_name = azurerm_subnet.k8s_vk_subnet.name
  # }
  # oms_agent {
  #   log_analytics_workspace_id = var.log_analytics_workspace_id
  # }

  #disabled ACI virtual node
  # network_profile {
  #   #load_balancer_sku = "standard"
  #   #outbound_type     = "loadBalancer"
  #   #disabled
  #   network_plugin = "azure" #When network_plugin is set to azure - the vnet_subnet_id field in the default_node_pool block must be set and pod_cidr must not be set.
  #   #network_policy     = "calico"
  #   #dns_service_ip     = "10.0.0.10"
  #   #docker_bridge_cidr = "172.17.0.1/16"
  #   #service_cidr       = "10.0.0.0/16"
  # }

  provisioner "local-exec" {
    command = "kubectl config delete-context ${self.name}"
    #interpreter = ["pwsh", "-Command"]
    #on_failure = continue
    when = destroy
  }
}
