#reuse these policies
ippool = "galaxy-hx2-1051"
sysconfig = "galaxy-sys-config-policy"
vmtype = "vm-default"
networkpolicy = "galaxy-network-policy"
version_policy = "K8sVersionPolicy1.19.5-iks-0"
infra_config_policy = "galaxy-vcenter-1051"

#create these policies
iks_cluster_name = "meenakshi-tf-cluster"

infraprovider = "galaxy-1051"
interfaces   = [ "DV_VLAN1051" ]
Datastore    = "CCPdatastore" 
Cluster      = "GFFA-HX2-Cluster"
ResourcePool = ""
