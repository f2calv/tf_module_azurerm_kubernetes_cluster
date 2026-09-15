output "id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.name
}

output "location" {
  description = "The location of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.location
}

output "fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "mi_principal_id" {
  description = "The principal ID of the cluster managed identity."
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
}

output "mi_tenant_id" {
  description = "The tenant ID of the cluster managed identity."
  value       = azurerm_kubernetes_cluster.this.identity[0].tenant_id
}

output "kubelet_client_id" {
  description = "The client ID of the kubelet managed identity."
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].client_id
}

output "kubelet_object_id" {
  description = "The object ID of the kubelet managed identity."
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

output "kubelet_user_assigned_identity_id" {
  description = "The user-assigned identity ID of the kubelet."
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].user_assigned_identity_id
}

output "kube_config_host" {
  description = "The Kubernetes cluster API server URL."
  value       = azurerm_kubernetes_cluster.this.kube_config[0].host
  sensitive   = true
}

output "kube_config_username" {
  description = "The Kubernetes cluster admin username."
  value       = azurerm_kubernetes_cluster.this.kube_config[0].username
  sensitive   = true
}

output "kube_config_password" {
  description = "The Kubernetes cluster admin password."
  value       = azurerm_kubernetes_cluster.this.kube_config[0].password
  sensitive   = true
}

output "kube_config_client_certificate" {
  description = "The base64-encoded client certificate for cluster authentication."
  value       = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
  sensitive   = true
}

output "kube_config_client_key" {
  description = "The base64-encoded client key for cluster authentication."
  value       = azurerm_kubernetes_cluster.this.kube_config[0].client_key
  sensitive   = true
}

output "kube_config_cluster_ca_certificate" {
  description = "The base64-encoded cluster CA certificate."
  value       = azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "kube_config" {
  description = "The raw kubeconfig for the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}
