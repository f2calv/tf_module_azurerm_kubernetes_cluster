output "id" {
  value = azurerm_kubernetes_cluster.k8s.id
}
output "name" {
  value = azurerm_kubernetes_cluster.k8s.name
}
output "location" {
  value = azurerm_kubernetes_cluster.k8s.location
}

output "fqdn" {
  value = azurerm_kubernetes_cluster.k8s.fqdn
}

output "mi_principal_id" {
  value = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
}

output "mi_tenant_id" {
  value = azurerm_kubernetes_cluster.k8s.identity[0].tenant_id
}

output "kubelet_client_id" {
  value = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].client_id
}

output "kubelet_object_id" {
  value = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}

output "kubelet_user_assigned_identity_id" {
  value = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].user_assigned_identity_id
}

output "kube_config_host" {
  value = azurerm_kubernetes_cluster.k8s.kube_config[0].host
}
output "kube_config_username" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].username
  sensitive = true
}
output "kube_config_password" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].password
  sensitive = true
}
output "kube_config_client_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate
  sensitive = true
}
output "kube_config_client_key" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].client_key
  sensitive = true
}
output "kube_config_cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw
}