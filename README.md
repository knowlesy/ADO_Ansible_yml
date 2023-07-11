# ADO_Ansible
Azure Devops Ansible Pipeline

This is a brief guide to setting up a simple environment for utilising ansible in an ADO Pipeline to configure Windows VM's

References below have helped in making this example 
* [Linux Machine Creation](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform)
* [Windows VM Creation](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-terraform)
* [Keyvault Creation](https://learn.microsoft.com/en-us/azure/key-vault/keys/quick-create-terraform?tabs=azure-cli)
* [Random Pet name generator](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet.html?source=post_page---------------------------#example-usage)
* [Issue with Null for keyvault current user access policy](https://stackoverflow.com/questions/64989203/terraform-create-a-azure-key-vault#:~:text=Upgrade%20to%20version%20%3D%20%22%3D3.42.0%22%20solveded%20for%20me%20the%20same%20issue)


Git clone and cd into the TF folder then run through the motions


Initialise

    terraform init -upgrade

Plan

    terraform plan -out main.tfplan

Apply

    terraform apply main.tfplan


DESTROY!!!!!!!!!!!!!

    terraform plan -destroy -out main.destroy.tfplan
    terraform apply "main.destroy.tfplan"
