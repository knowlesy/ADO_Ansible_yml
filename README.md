# ADO_Ansible
Azure Devops Ansible Pipeline

ADO = Azure Devops

This is a brief guide to setting up a simple environment for utilising ansible in an ADO Classic Pipeline to configure Windows VM's

This is a lab only !


## Pre-Reqs

* Azure Devops Orginisation and Project for testing
* terraform installed locally
* VSCode with TF Extension and Git
* AZ Cli or AZ PS Module 
* Azure Environment 

## Instructions

Git clone in VS Code and cd into the TF folder then run through the motions

Import the repo t your test project in ADO [Guide](https://learn.microsoft.com/en-us/azure/devops/repos/git/import-git-repository?view=azure-devops)

Update the ado.sh file replacing all items within the <> brackets, dont forget to remove the brackets (see [here](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows) for how to create PAT Tokens and [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops&tabs=yaml%2Cbrowser) for Agent pools)

In your VSCode Terminal 

Log in to azure [AZ CLI](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli) or [Powershell](https://learn.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-10.1.0)

Initialise TF Code

    terraform init -upgrade

Plan TF Code

    terraform plan -out main.tfplan

Apply TF Code

    terraform apply main.tfplan


DESTROY!!!!!!!!!!!!!

    terraform plan -destroy -out main.destroy.tfplan
    terraform apply "main.destroy.tfplan"



References below have helped in making this example 
* [Ansible Credssp](https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html#credssp)
* [Uploading multiple files to a SA with TF](https://thomasthornton.cloud/2022/07/11/uploading-contents-of-a-folder-to-azure-blob-storage-using-terraform/)
* [Ansible on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04)
* [Server did not response with a CredSSP ](https://stackoverflow.com/questions/62157332/ansible-winrm-server-did-not-response-with-a-credssp-token-after-step-step-5)
* [Ansible Dynamic Libraries in Azure](https://learn.microsoft.com/en-us/azure/developer/ansible/dynamic-inventory-configure?tabs=azure-cli)
