data "azurerm_resource_group" "k8s_rg" {
  name = var.k8s_resource_group_name
}

data "azurerm_subscription" "current" {}

data "azurerm_kubernetes_service_versions" "current" {
  location        = data.azurerm_resource_group.k8s_rg.location
  include_preview = false
}

# data "azuread_group" "aad" {
#   name  = var.aad_group_name
# }
