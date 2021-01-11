# terraform-iks
A Terrraform Plan for building an IKS cluster in Intersight

# Usage

Copy the terraform.tfvars.example file to terraform.tfvars
Edit the values in this document.

Initialize your terraform provider
````
tf init

````

plan your infrastructure change.
````
tf plan

````

apply your infrastructure change.
````
tf apply.

````

# Caveats

I would recommend creating a ResourcePool in vCenter and use this.
At the moment there is a bug when you don't specify a resourcepool.
