variable "api_key" {
  type = string
  description = "API Key Id from Intersight"
}
variable "secretkeyfile" {
  type = string
  description = "The path to your secretkey for Intersight"
}
variable "organization" {
  type = string
  description = "Organization Name"
  default = "Default"
}

variable "vcenter_device_ip_address" {
  type = list(string)
  description = "The IP address of the vCenter Target you want to provision your IKS cluster to"
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

variable "ippool_from" {
  type = string
  description = "The First IP address of your IP Pool"
}

variable "ippool_size" {
  type = number
  description = "The amount of sequential IP's in your IP space starting from the first one."
}

variable "ippool_gateway" {
  type = string
  description = "The Gateway of your IP Pool"
}

variable "ippool_netmask" {
  type = string
  description = "The Netmask of your IP Pool"
}

variable "ippool_primary_dns" {
  type = string
  description = "The Primary DNS of your IP Pool"
}

variable "ippool_secondary_dns" {
  type = string
  description = "The Secondary DNS of your IP Pool"
}

variable "iks_cluster_name" {
  type = string
  description = "The Name of your IKS cluster"
}

variable "dns_domain_name" {
  type = string
  description = "The DNS domainname IKS cluster"
}

variable "dns_servers" {
  type = list(string)
  description = "The DNS servers to use inside your IKS cluster"
}

variable "ntp_servers" {
  type = list(string)
  description = "The NTP servers to use inside your IKS cluster"
  default = [ "ntp.esl.cisco.com" ]
}

variable "timezone" {
  type = string
  description = "The timezone for the IKS cluster"
  default = "Europe/Amsterdam"
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

variable "cpu" {
  type = number
  description = "The number of vCPU's for the VM's of the IKS cluster"
  default = 2
}

variable "disk_size" {
  type = number
  description = "The size of your harddisk in GB for the VM's of the IKS cluster"
  default = 32
}

variable "memory" {
  type = number
  description = "The size of your memory in MB for the VM's inside of the IKS cluster"
  default = 16384
}

variable "pod_network_cidr" {
  type = string
  description = "The CIDR of your pods"
  default = "172.100.0.0/16"
}

variable "service_cidr" {
  type = string
  description = "The CIDR for your k8s services"
  default = "192.168.10.0/24"
}

variable "proxy_hostname" {
  type = string
  description = "The hostname of your proxy"
  default = "proxy.esl.cisco.com"
}

variable "proxy_port" {
  type = number
  description = "The port of your proxy"
  default = 80
}

variable "proxy_protocol" {
  type = string
  description = "The protocol of your proxy"
  default = "http"
}








