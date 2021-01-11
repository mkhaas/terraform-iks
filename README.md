# terraform-iks
A Terrraform Plan for building an IKS cluster in Intersight

# Usage
Copy the terraform.tfvars.example file to terraform.tfvars
Edit the values in this document.

Initialize your terraform provider
````
tf init
````

Plan your infrastructure change.
````
tf plan
````

Apply your infrastructure change.
````
tf apply.
````
Now login to Intersight and you should see your Profile under Profiles.
I choose not to deploy the profile from terraform, as I believe the Terraform Provider is not suitable for this at the moment.
The reason is that I'm unsure at the moment what the behavior is when destroying from Terraform.
Will it undeploy and delete the VM and release the IP leases?
I don't know for sure, so that's why I deploy and undeploy manually at the moment.

# Caveats

1. Resource pools. 
At the moment there is a bug that needs you to specify a resourcepool or you will recieve the following error:
"path 'Resources' resolves to multiple resource pools."
2. Everytime you apply the terraform plan it will reconfigure the password for your Infrastructure Provider.
I'm looking for a way around this.