variable "k8s_resource_group_name" {
  type        = string
  description = "Name of the parent resource group."
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {}
}

variable "k8s_cluster_name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "k8s_cluster_dns_prefix" {
  description = "Optional DNS prefix to use with hosted Kubernetes API server FQDN."
  type        = string
}

variable "k8s_node_resource_group" {
  description = "Resource group for the internal objects of the node pool."
  type        = string
}

variable "k8s_node_pool_name" {
  description = "The name of the default AKS node pool."
  type        = string
}

variable "k8s_node_count" {
  description = "The number of VM nodes in the default AKS node pool."
  type        = number
}

variable "k8s_vm_size" {
  description = "The size of the VM nodes in the default AKS node pool."
  type        = string
}

variable "k8s_vm_disk_size" {
  description = "Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 30 to 1023. Specifying 0 applies the default disk size for that agentVMSize."
  type        = number
  default     = 30
}

variable "k8s_vm_max_pods" {
  description = "Max pods per node."
  type        = number
  default     = 100
}

variable "k8s_vnet_subnet_id" {
  type        = string
  description = "Resource ID of the subnet used by the default AKS node pool."
  default     = null
}

variable "k8s_automatic_channel_upgrade" {
  type        = string
  description = "Automatic Kubernetes version upgrade channel."
}

variable "k8s_node_os_channel_upgrade" {
  type        = string
  description = "Automatic node OS upgrade channel."
}

variable "k8s_maintenance_day_of_week" {
  type        = string
  description = "Day of the week for automatic Kubernetes and node OS maintenance."
}

variable "k8s_maintenance_start_time" {
  type        = string
  description = "Start time for automatic Kubernetes and node OS maintenance."
}

variable "k8s_maintenance_duration_hours" {
  type        = number
  description = "Duration in hours for automatic Kubernetes and node OS maintenance."
}

variable "k8s_maintenance_utc_offset" {
  type        = string
  description = "UTC offset for the automatic Kubernetes and node OS maintenance schedule."
}
