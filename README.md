---
title: Terraform Module for Azure Kubernetes Service
description: Provision an Azure Kubernetes Service cluster with managed identity and RBAC
---

Provisions an [Azure Kubernetes Service](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) cluster with SystemAssigned managed identity and RBAC enabled. Automatically tracks the latest non-preview Kubernetes version.

## Usage

```hcl
module "k8s" {
  source                  = "git::https://github.com/f2calv/tf_module_azurerm_kubernetes_cluster.git//src?ref=v0.2.0"
  k8s_resource_group_name = azurerm_resource_group.rg.name
  k8s_cluster_name        = "mycluster"
  k8s_cluster_dns_prefix  = "mycluster-dns"
  k8s_node_resource_group = "mycluster-node-rg"
  k8s_node_pool_name      = "nodepool0"
  k8s_node_count          = 1
  k8s_vm_size             = "Standard_D2ps_v5"
  k8s_vnet_subnet_id      = azurerm_subnet.aks.id
  tags                    = { environment = "dev" }
}
```

## Variables

| Name | Type | Default | Description |
| --- | --- | --- | --- |
| `k8s_resource_group_name` | `string` | Required | Name of the parent resource group |
| `k8s_cluster_name` | `string` | Required | Name of the AKS cluster |
| `k8s_cluster_dns_prefix` | `string` | Required | DNS prefix for the hosted Kubernetes API server FQDN |
| `k8s_node_resource_group` | `string` | Required | Resource group for node pool internal objects |
| `k8s_node_pool_name` | `string` | Required | The name of the default node pool |
| `k8s_node_count` | `number` | Required | The number of VM nodes in the default pool |
| `k8s_vm_size` | `string` | Required | The size of the VM nodes |
| `k8s_vm_disk_size` | `number` | `30` | Disk size (GB) per node |
| `k8s_vm_max_pods` | `number` | `100` | Max pods per node |
| `k8s_vnet_subnet_id` | `string` | Required | Resource ID of the subnet used by the default AKS node pool |
| `tags` | `map(string)` | `{}` | Tags for all resources |

## Outputs

| Name | Sensitive | Description |
| --- | --- | --- |
| `id` | No | The ID of the AKS cluster |
| `name` | No | The name of the AKS cluster |
| `location` | No | The location of the AKS cluster |
| `fqdn` | No | The FQDN of the AKS cluster |
| `mi_principal_id` | No | The principal ID of the cluster managed identity |
| `mi_tenant_id` | No | The tenant ID of the cluster managed identity |
| `kubelet_client_id` | No | The client ID of the kubelet managed identity |
| `kubelet_object_id` | No | The object ID of the kubelet managed identity |
| `kubelet_user_assigned_identity_id` | No | The user-assigned identity ID of the kubelet |
| `kube_config_host` | Yes | The Kubernetes cluster API server URL |
| `kube_config_username` | Yes | The cluster admin username |
| `kube_config_password` | Yes | The cluster admin password |
| `kube_config_client_certificate` | Yes | The base64-encoded client certificate |
| `kube_config_client_key` | Yes | The base64-encoded client key |
| `kube_config_cluster_ca_certificate` | Yes | The base64-encoded cluster CA certificate |
| `kube_config` | Yes | The raw kubeconfig for the AKS cluster |
