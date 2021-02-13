#Importing the Kubernetes Version available
data "intersight_kubernetes_version" "iks_1_18" {
  #  name = "IKS-master-94a8577-v1.18.12"
    kubernetes_version = "v1.18.12"
}

data "intersight_organization_organization" "org" {
    name = var.organization
}

#Importing the vCenter Target to assign to the Infra Provider
data "intersight_asset_target" "vcenter" {
    name = var.vcenter_name
    target_type = "VmwareVcenter"
}

data "intersight_kubernetes_addon_definition" "dashboard_addon_def" {
    name = var.addon_definition_name
}

resource "intersight_kubernetes_virtual_machine_infrastructure_provider" "IKS-InfraProvider-AMSLAB-All_Flash" {
    name    = "IKS-InfraProvider-AMSLAB-All_Flash"
    infra_config { 
        object_type = "kubernetes.EsxiVirtualMachineInfraConfig"
        interfaces = var.interfaces
        additional_properties = jsonencode({
            Datastore = var.Datastore
            Cluster = var.Cluster
            Passphrase = var.Passphrase
            ResourcePool = var.ResourcePool
        })
    }

    instance_type {
        object_type = "kubernetes.VirtualMachineInstanceType"
        moid = intersight_kubernetes_virtual_machine_instance_type.IKS-VM-Template-default.id
    }

    target {
        object_type = "asset.DeviceRegistration"
        moid = data.intersight_asset_target.vcenter.registered_device[0].moid
    }

    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.id
    }
}

resource "intersight_kubernetes_node_group_profile" "iks-master_nodepool-1master" {
    name = "iks-master_nodepool-1master"
    description = "The Master Node pool with just 1 master "
    node_type = "Master"
    desiredsize = var.master_desiredsize

    #references
    infra_provider {
        object_type = "kubernetes.VirtualMachineInfrastructureProvider"
        moid = intersight_kubernetes_virtual_machine_infrastructure_provider.IKS-InfraProvider-AMSLAB-All_Flash.id
    }

    ip_pools {
        object_type = "ippool.Pool"
        moid = intersight_ippool_pool.IKS-ippool-amslab.id
    }

    kubernetes_version {
        object_type = "kubernetes.VersionPolicy"
        moid = intersight_kubernetes_version_policy.IKS-version-1_18.id
    }

    cluster_profile {
      object_type = "kubernetes.ClusterProfile"
      moid = intersight_kubernetes_cluster_profile.IKS-k8s-profile.id
    } 

    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
}

resource "intersight_kubernetes_node_group_profile" "iks-worker_nodepool-2workers" {
    name = "iks-worker_nodepool-2workers"
    description = "The Worker Nodepool with 2 Workers "
    node_type = "Worker"
    desiredsize = var.worker_desiredsize

    infra_provider {
        object_type = "kubernetes.VirtualMachineInfrastructureProvider"
        moid = intersight_kubernetes_virtual_machine_infrastructure_provider.IKS-InfraProvider-AMSLAB-All_Flash.id
    }

    ip_pools {
        object_type = "ippool.Pool"
        moid = intersight_ippool_pool.IKS-ippool-amslab.id
    }

    kubernetes_version {
        object_type = "kubernetes.VersionPolicy"
        moid = intersight_kubernetes_version_policy.IKS-version-1_18.id
    }

    cluster_profile {
      object_type = "kubernetes.ClusterProfile"
      moid = intersight_kubernetes_cluster_profile.IKS-k8s-profile.id
    }

    tags { 
        key = "Managed_By"
        value = "Terraform" 
    }
}

resource "intersight_ippool_pool" "IKS-ippool-amslab"{
    name = "IKS-ippool-amslab"
    description = "The IP Pool used for Kubernetes deployments"
    ip_v4_blocks {
        object_type = "ippool.IpV4Block"
        from = var.ippool_from
        size = var.ippool_size
    } 
    ip_v4_config {
        object_type = "ippool.IpV4Config"
        gateway = var.ippool_gateway
        netmask = var.ippool_netmask
        primary_dns = var.ippool_primary_dns
        secondary_dns = var.ippool_secondary_dns
    }
    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.id
    }
}

resource "intersight_kubernetes_sys_config_policy" "IKS-Sys-Config-Default" {
  name = "IKS-Sys-Config-Default"
  description = "The default NTP and DNS settings for AMSLAB"
  dns_domain_name = var.dns_domain_name
  dns_servers = var.dns_servers
  ntp_servers = var.ntp_servers
  timezone = var.timezone

  tags { 
    key = "Managed_By"
    value = "Terraform"
  }
  
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.org.id
  }
}

resource "intersight_kubernetes_virtual_machine_instance_type" "IKS-VM-Template-default" {
  name = "IKS-VM-Template-default"
  description = "The default VM specs to use whole deploying an Kubernetes Cluster"
  cpu = var.cpu
  disk_size = var.disk_size
  memory = var.memory
  tags { 
    key = "Managed_By"
    value = "Terraform"
  }
  organization {
    object_type = "organization.Organization"
    moid = data.intersight_organization_organization.org.id
  }
}

resource "intersight_kubernetes_version_policy" "IKS-version-1_18" {
    name = "IKS-version-1_18"
    nr_version {
        object_type =  "kubernetes.Version"
        moid = data.intersight_kubernetes_version.iks_1_18.id
    }

    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.id
    } 
}

resource "intersight_kubernetes_network_policy" "IKS-network-policy-cluster1" {
    name = "IKS-network-policy-cluster1"
    description = "The network Policy for the cluster "
    # cni_config {
    #     object_type = ""
    #     nr_version = ""
    # }
    #cni_type = "calico" # Supported CNI type. Currently we only support Calico.\n* `Calico` - Calico CNI plugin as described in https://github.com/projectcalico/cni-plugin.\n* `Aci` - Cisco ACI Container Network Interface plugin.",
    pod_network_cidr = var.pod_network_cidr
    service_cidr = var.service_cidr
    
    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.id
    } 
}

resource "intersight_kubernetes_container_runtime_policy" "IKS-container-runtime_with_proxy" {
    name = "IKS-container-runtime_with_proxy"
    description = "This policy configures the Proxy setting for your container runtime so you can get container images from the internet"
    
    docker_http_proxy {
        object_type = "kubernetes.ProxyConfig"
        hostname = var.proxy_hostname
        port = var.proxy_port
        protocol = var.proxy_protocol
        is_password_set = false
    }
    docker_https_proxy {
        object_type = "kubernetes.ProxyConfig"
        hostname = var.proxy_hostname
        port = var.proxy_port
        protocol = var.proxy_protocol
        is_password_set = false
    }

    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.id
    } 
}

resource "intersight_kubernetes_addon" "dashboard_addon" {
    name = var.addon_definition_name
    upgrade_strategy = var.addon_upgrade_strategy
    addon_definition {
        moid = data.intersight_kubernetes_addon_definition.dashboard_addon_def.moid
    }
        
    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.id
    }     
}
resource "intersight_kubernetes_addon_policy" "IKS-Dashboard" {
    name = "IKS-Dashboard"        
    tags { 
        key = "Managed_By"
        value = "Terraform"
    }

    addons {
        object_type = "kubernetes.Addon"
        moid = intersight_kubernetes_addon.dashboard_addon.moid
    }   

    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.id
    } 
}

resource "intersight_kubernetes_cluster_profile" "IKS-k8s-profile" {
    name = var.iks_cluster_name
    description = "This Kubernetes Cluster profile has been created via Terraform"
    management_config {
        object_type = "kubernetes.ClusterManagementConfig"
        load_balancer_count = var.load_balancer_count
        ssh_keys = var.ssh_keys
        ssh_user = var.ssh_user
    }
    #action = "Deploy"

    #references
    addons {
        object_type = "kubernetes.AddonPolicy"
        moid = intersight_kubernetes_addon_policy.IKS-Dashboard.id
    }

    cluster_ip_pools {
        object_type = "ippool.Pool"
        moid = intersight_ippool_pool.IKS-ippool-amslab.id
    }

    container_runtime_config { 
        object_type = "kubernetes.ContainerRuntimePolicy"
        moid = intersight_kubernetes_container_runtime_policy.IKS-container-runtime_with_proxy.id
    }

    net_config {
        object_type = "kubernetes.NetworkPolicy"
        moid = intersight_kubernetes_network_policy.IKS-network-policy-cluster1.id
    }

    sys_config {
        object_type = "kubernetes.SysConfigPolicy"
        moid = intersight_kubernetes_sys_config_policy.IKS-Sys-Config-Default.id
    }

    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.id
    } 
}
