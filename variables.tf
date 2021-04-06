variable "api_key" {
  type = string
  description = "API Key Id from Intersight"
}
variable "secretkey" {
  type = string
  description = "The path to your secretkey for Intersight OR the your secret key as a string"
}
variable "organization" {
  type = string
  description = "Organization Name"
  default = "default"
}
variable "ippool" {
  type = string
}
variable "sysconfig" {
  type = string
}

variable "infra_config_policy" {
  type = string
}

variable "vmtype" {
  type = string
}

variable "networkpolicy" {
  type = string
}
variable "version_policy" {
  type = string
}

variable "master_desiredsize" {
  type = number
  description = "The amount of Masters in your IKS cluster."
  default = 1
}

variable "worker_desiredsize" {
  type = number
  description = "The amount of Workers in your IKS cluster."
  default = 2
}

variable "iks_cluster_name" {
  type = string
  description = "The Name of your IKS cluster"
}

variable "ssh_user" {
  type = string
  description = "The ssh_user for the IKS cluster"
  default = "iksadmin"
}

variable "ssh_keys" {
  type = list(string)
  description = "The ssh_key for the IKS cluster"
}

variable "load_balancer_count" {
  type = number
  description = "The number of loadbalancers for the IKS cluster"
  default = 3
}

variable "vcenter_name" {
  type = string
  description = "The name of your vCenter Target as you see it in Intersight (could be an IP address)"
}

