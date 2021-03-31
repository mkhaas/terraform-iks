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
variable "infraprovider" {
  type = string
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
  default = 1
}

variable "vcenter_name" {
  type = string
  description = "The name of your vCenter Target as you see it in Intersight (could be an IP address)"
}

variable "interfaces" {
  type = list(string)
  description = "The name of the VM network(s) you want the IKS VM's to utilize."
}

variable "Datastore" {
  type = string
  description = "The Datastore on which the IKS VM's need to be deployed"
}

variable "Cluster" {
  type = string
  description = "The Cluster on which the IKS VM's need to be deployed"
}

variable "Passphrase" {
  type = string
  description = "The Passphrase for the administrator@vsphere.local user of your vCenter environment"
}

variable "ResourcePool" {
  type = string
  description = "The ResourcePool on which the IKS VM's need to be deployed. At the moment this cannot be empty due to a bug"
}