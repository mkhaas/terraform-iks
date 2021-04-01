data "intersight_organization_organization" "org" {
    name = var.organization
}

data "intersight_asset_target" "vcenter" {
    name = var.vcenter_name
    target_type = "VmwareVcenter"
}

data "intersight_ippool_pool" "ippool" {
    name = var.ippool
}

data "intersight_kubernetes_sys_config_policy" "sys_config" {
    name = var.sysconfig
}

data "intersight_kubernetes_virtual_machine_instance_type" "vm_type" {
    name = var.vmtype
}

data "intersight_kubernetes_network_policy" "network_policy" {
    name = var.networkpolicy
}

data "intersight_kubernetes_version_policy" "version_policy" {
    name = var.version_policy
}

data "intersight_kubernetes_virtual_machine_infra_config_policy" "infra_config_policy" {
    name = var.infra_config_policy
}

resource "intersight_kubernetes_virtual_machine_infrastructure_provider" "infra_provider-control" {
    name    = "${var.iks_cluster_name}-controlplane"
    # infra_config { 
    #     object_type = "kubernetes.EsxiVirtualMachineInfraConfig"
    #     interfaces = var.interfaces
    #     additional_properties = jsonencode({
    #         Datastore = var.Datastore
    #         Cluster = var.Cluster
    #         Passphrase = var.Passphrase 
    #         ResourcePool = var.ResourcePool
    #     })
    # }  
    infra_config_policy {
      moid = data.intersight_kubernetes_virtual_machine_infra_config_policy.infra_config_policy.results[0].moid
      object_type = "kubernetes.VirtualMachineInfraConfigPolicy"
    } 
    instance_type {
        object_type = "kubernetes.VirtualMachineInstanceType"
        moid = data.intersight_kubernetes_virtual_machine_instance_type.vm_type.results[0].moid
    }

    target {
        object_type = "asset.DeviceRegistration"
        moid = data.intersight_asset_target.vcenter.results[0].registered_device[0].moid
    }

    node_group {
        object_type = "kubernetes.NodeGroupProfile"
        moid = intersight_kubernetes_node_group_profile.iks-master_nodepool-1master.id
    }

    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
}

resource "intersight_kubernetes_virtual_machine_infrastructure_provider" "infra_provider-worker" {
    name    = "${var.iks_cluster_name}-workers"
    # infra_config { 
    #     object_type = "kubernetes.EsxiVirtualMachineInfraConfig"
    #     interfaces = var.interfaces
    #     additional_properties = jsonencode({
    #         Datastore = var.Datastore
    #         Cluster = var.Cluster
    #         Passphrase = var.Passphrase 
    #         ResourcePool = var.ResourcePool
    #     })
    # }
    instance_type {
        object_type = "kubernetes.VirtualMachineInstanceType"
        moid = data.intersight_kubernetes_virtual_machine_instance_type.vm_type.results[0].moid
    }

   infra_config_policy {
      moid = data.intersight_kubernetes_virtual_machine_infra_config_policy.infra_config_policy.results[0].moid
      object_type = "kubernetes.VirtualMachineInfraConfigPolicy"
    } 
    target {
        object_type = "asset.DeviceRegistration"
        moid = data.intersight_asset_target.vcenter.results[0].registered_device[0].moid
    }

    node_group {
        object_type = "kubernetes.NodeGroupProfile"
        moid = intersight_kubernetes_node_group_profile.iks-master_nodepool-1master.id
    }

    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
}


resource "intersight_kubernetes_node_group_profile" "iks-master_nodepool-1master" {
    name = "iks-master_nodepool-1master"
    description = "The Master Node pool with just 1 master "
    node_type = "ControlPlane"
    desiredsize = var.master_desiredsize
    maxsize = 3
    ip_pools {
        object_type = "ippool.Pool"
        moid = data.intersight_ippool_pool.ippool.results[0].moid
    }

    kubernetes_version {
        object_type = "kubernetes.VersionPolicy"
        moid = data.intersight_kubernetes_version_policy.version_policy.results[0].moid
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
    maxsize = 50         
    
    ip_pools {
        object_type = "ippool.Pool"
        moid = data.intersight_ippool_pool.ippool.results[0].moid
    }

    kubernetes_version {
        object_type = "kubernetes.VersionPolicy"
        moid = data.intersight_kubernetes_version_policy.version_policy.results[0].moid
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
    wait_for_completion=false

    cluster_ip_pools {
        object_type = "ippool.Pool"
        moid = data.intersight_ippool_pool.ippool.results[0].moid
    }

    net_config {
        object_type = "kubernetes.NetworkPolicy"
        moid = data.intersight_kubernetes_network_policy.network_policy.results[0].moid
    }

    sys_config {
        object_type = "kubernetes.SysConfigPolicy"
        moid = data.intersight_kubernetes_sys_config_policy.sys_config.results[0].moid
    }

    tags { 
        key = "Managed_By"
        value = "Terraform"
    }
    organization {
        object_type = "organization.Organization"
        moid = data.intersight_organization_organization.org.results[0].moid
    } 
}
