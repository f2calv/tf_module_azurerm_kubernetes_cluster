#https://www.terraform.io/docs/configuration/variables.html

variable "k8s_resource_group_name" {
  type        = string
  description = "Name of the parent resource group."
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the resources."
  default     = {}
  #   default = {
  #     Environment = "staging"
  #   }
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
  description = "group all internal objects of the node pool."
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


variable "k8s_dashboard_enable" {
  description = "Enable AKS default dashboard."
  type        = bool
  default     = false
}


variable "k8s_vnet_name" {
  type = string
}
variable "k8s_vnet_subnet_name" {
  type = string
}
variable "k8s_vk_subnet_name" {
  type = string
}




# variable aad_group_name {
#   type = string
# }



# variable "ssh_public_key" {
#   type    = string
#     default = "~/.ssh/id_rsa.pub"
# }




# variable log_analytics_workspace_name {
#   type    = string
#   default = "testLogAnalyticsWorkspaceName"
# }

# # refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
# variable log_analytics_workspace_location {
#   type    = string
#   default = "West Europe"
# }

# # refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
# variable log_analytics_workspace_sku {
#   type    = string
#   default = "PerGB2018"
# }