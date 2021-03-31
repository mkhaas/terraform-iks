#reuse these policies
ippool = "IKS-ippool-amslab"
sysconfig = "IKS-Sys-Config-Default"
vmtype = "IKS-VM-Template-default"
networkpolicy = "IKS-network-policy-cluster1"
version_policy = "IKS-version-1_19"
infra_config_policy = "NVME-Cluster"

#create these policies
iks_cluster_name = "meenakshi-tf-cluster"

infraprovider = "NVME-Cluster-2"
interfaces   = [ "vlan99-99" ]
Datastore    = "HX-NVME" 
Cluster      = "HX-NVME"
ResourcePool = ""