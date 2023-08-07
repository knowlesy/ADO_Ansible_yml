# ADO_Ansible
Azure Devops Ansible Pipeline

ADO = Azure Devops

This is a brief guide to setting up a simple environment for utilizing ansible in an ADO YAML Pipeline to configure Windows VM's utilising winping as a demo to prove this works

This is a lab only !

## Pre-Req's

* Azure Devops Organization and Project for testing
* terraform installed locally
* VSCode with TF Extension and Git
* AZ Cli or AZ PS Module 
* Azure Environment 
* Ansible ADO Extension installed [here](https://marketplace.visualstudio.com/items?itemName=ms-vscs-rm.vss-services-ansible)
* Azure Service Principle created  and set up in Azure devops [guide](https://learn.microsoft.com/en-us/azure/devops/integrate/get-started/authentication/service-principal-managed-identity?view=azure-devops) , [alt guide](https://learn.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli)

## Instructions

Git clone in VS Code and cd into the TF folder then run through the motions

Import the repo into your test project in ADO [Guide](https://learn.microsoft.com/en-us/azure/devops/repos/git/import-git-repository?view=azure-devops)

Update the ado.sh file replacing all items within the <> brackets, don't forget to remove the brackets (see [here](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows) for how to create PAT Tokens and [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops&tabs=yaml%2Cbrowser) for Agent pools)

In your VSCode Terminal 

Log in to azure [AZ CLI](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli) or [Powershell](https://learn.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-10.1.0)

Initialize TF Code

    terraform init -upgrade

Plan TF Code

    terraform plan -out main.tfplan

Apply TF Code

    terraform apply main.tfplan

In your web browser and in ADO Project or Org settings check the agent is showing

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/5eff9620-d581-4c54-8986-dd3306a8bd3c)

Ensure your Service Principle has access to the keyvault (note if you haven't done this you can manually set these later instead of linking a keyvault ensuring their hidden) [guide for SP on keyvault](https://learn.microsoft.com/en-us/azure/key-vault/general/assign-access-policy?tabs=azure-portal)

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/f86de58d-6b6b-4001-bb4b-dc089416bbcc)

Create Library groups

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/a5ce98f8-2137-493a-a24b-a1e7754f811a)

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/47e699ab-5709-46c0-9988-9cc2e3d46430)

Click "Link Secrets" from... (if your not using a SP create secure variables here)

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/c0ab10c5-4bda-41d8-9574-5edb5d4f5dff)

Fill in the details 

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/f381f8fd-90b3-44ac-8555-7179735a4396)

Click "add", select the password and click "ok"

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/929a1d55-3c39-4882-8cf9-a920f6e79982)

Set the name of this library and click "save" 

Create a Pipeline 

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/3ec03826-5bdf-4c59-9bf5-e22e1531926a)

Select Classic 

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/15acfc29-45b0-4057-bb39-041cc3d2380e)

Click Continue

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/59474e24-e14f-4cb0-a1e3-9486b5b46ae3)

Click empty at the top 

Click agent pool and select your agent pool name 

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/8fadcf25-0a06-439e-adf6-0804cfa7c87f)

on agent job click the + sign and select Ansible

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/08b26e72-8c6c-4d86-8dbb-d1c8ffa4cfe3)

Browse and select the winping.yml file 

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/438d421b-0923-4235-b339-43008490151a)

set Inventory to inline and copy the contents of the inventory.ini file, then paste in the Content text box below. Ensure you update the <ip address..> with the local ip of the windows vm

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/fc7d272f-0e97-4c9e-9323-d622997d6b07)

Click "Variables" then "variable groups". Click "Link variable"...select your library group

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/35cd6921-f0ef-44c6-95e8-7384523539e1)

click "Save&Queue" then click save and run  

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/78b79eb3-0a78-49d2-9692-23fb4a936104)

Click "agent job 1" and click "run playbook "

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/0eb1fcbb-98ce-49eb-a57f-dfab49500de4)

That should be it and time to take down the environment 

DESTROY!!!!!!!!!!!!!

    terraform plan -destroy -out main.destroy.tfplan
    terraform apply "main.destroy.tfplan"

References below have helped in making this example 
* [Ansible Credssp](https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html#credssp)
* [Uploading multiple files to a SA with TF](https://thomasthornton.cloud/2022/07/11/uploading-contents-of-a-folder-to-azure-blob-storage-using-terraform/)
* [Ansible on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04)
* [Server did not response with a CredSSP ](https://stackoverflow.com/questions/62157332/ansible-winrm-server-did-not-response-with-a-credssp-token-after-step-step-5)
* [Ansible Dynamic Libraries in Azure](https://learn.microsoft.com/en-us/azure/developer/ansible/dynamic-inventory-configure?tabs=azure-cli)
* [ADO Ansible](https://theazureblog.co.uk/azure-devops-ansible)
