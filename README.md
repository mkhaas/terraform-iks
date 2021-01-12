# terraform-iks
A Terrraform Plan for building an IKS cluster in Intersight

## Pre-requirements
- Install Terraform
- Intersight API key

## Usage
1. Copy the terraform.tfvars.example file to terraform.tfvars  
   Edit the values in this document.

2. Initialize your terraform provider.  
`tf init`

3. Plan your infrastructure change.  
`tf plan`

4. Apply your infrastructure change.  
`tf apply`

Now login to Intersight and you should see your Profile under Profiles.  
I choose not to deploy the profile from terraform, as I'm unsure what happens when destroying from Terraform.  
As I'm not sure I deploy and undeploy manually at the moment.  

## Caveats
1. Resource pools.  
At the moment there is a bug that needs you to specify a resourcepool in certain situations (multiple clusters or dc's) or you will recieve the following error:  
`"path 'Resources' resolves to multiple resource pools."`  
2. Everytime you apply the terraform plan it will reconfigure the password for your Infrastructure Provider.  
I'm looking for a way around this.  

## Todo

- Seperate between general and cluster specific resources
- Allow for more then 1 cluster to be created.
- Fix the problem with the password.
