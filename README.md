# ADO_Ansible_YML
Azure Devops Ansible Pipeline

ADO = Azure Devops

This is a brief guide to setting up a simple environment for utilizing ansible in an ADO YAML Pipeline to connect to a Windows VM's utilising winping as a demo to prove this works

This is a lab only !

## Pre-Req's

* Azure Devops Organization and Project for testing
* Devops Connection  to Azure with read access to all (In this example i used the service principle in the connection for accessing the keyvault and logging in to azure)
* Agent pool (Name: Ansible) created and PAT token at the ready, information on how below. 
* terraform installed locally
* VSCode with TF Extension and Git
* AZ Cli or AZ PS Module 
* Azure Subscription
* Azure Service Principle created (keep a hold of the details) [guide](https://learn.microsoft.com/en-us/azure/devops/integrate/get-started/authentication/service-principal-managed-identity?view=azure-devops) , [alt guide](https://learn.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli)

## Instructions

Import the repo into your test project in ADO [Guide](https://learn.microsoft.com/en-us/azure/devops/repos/git/import-git-repository?view=azure-devops)

### Git clone in VS Code 

Update the ado.sh file replacing all items within the <> brackets, don't forget to remove the brackets (see [here](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops&tabs=Windows) for how to create PAT Tokens and [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops&tabs=yaml%2Cbrowser) for Agent pools)

Update the ansible_demo.yml file with 

* tennant id
* app id (your service principle id)

### In your VSCode Terminal 

CD into the TF folder

Log in to azure [AZ CLI](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli) or [Powershell](https://learn.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-10.1.0)

Initialize TF Code

    terraform init -upgrade

Plan TF Code

    terraform plan -out main.tfplan

Apply TF Code

    terraform apply main.tfplan

In your web browser and in ADO Project or Org settings check the agent is showing

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/5eff9620-d581-4c54-8986-dd3306a8bd3c)

Ensure your Service Principle has access to the newly created keyvault with permissions to read all secrets

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/f86de58d-6b6b-4001-bb4b-dc089416bbcc)


In your keyvault add an additional secret

* password

set the value of your service principle password and click save


Create Library groups

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/a5ce98f8-2137-493a-a24b-a1e7754f811a)

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/47e699ab-5709-46c0-9988-9cc2e3d46430)

Click "Link Secrets" from... (if your not using a SP create secure variables here)

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/c0ab10c5-4bda-41d8-9574-5edb5d4f5dff)

Fill in the details 

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/f381f8fd-90b3-44ac-8555-7179735a4396)

Click "add", select the serverPassword and click "ok" repeat for password

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/929a1d55-3c39-4882-8cf9-a920f6e79982)

Name the variable group as "Ansible" and click Save


Create a Pipeline 

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/3ec03826-5bdf-4c59-9bf5-e22e1531926a)

Select Azure Repos Git 

![image](https://github.com/knowlesy/ADO_Ansible/assets/20459678/15acfc29-45b0-4057-bb39-041cc3d2380e)

Click your project name 

Click Existing Azure Pipelines yaml file

in main branch select the file "/Pipeline/ansible_demo.yml" Click continue

Click Save and run 

That should be it and time to take down the environment 

DESTROY!!!!!!!!!!!!!

    terraform plan -destroy -out main.destroy.tfplan
    terraform apply "main.destroy.tfplan"

For further reading and sources that helped this post  please see the below
* [Ansible Credssp](https://docs.ansible.com/ansible/latest/os_guide/windows_winrm.html#credssp)
* [Uploading multiple files to a SA with TF](https://thomasthornton.cloud/2022/07/11/uploading-contents-of-a-folder-to-azure-blob-storage-using-terraform/)
* [Ansible on Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-20-04)
* [Server did not response with a CredSSP ](https://stackoverflow.com/questions/62157332/ansible-winrm-server-did-not-response-with-a-credssp-token-after-step-step-5)
* [Ansible Dynamic Libraries in Azure](https://learn.microsoft.com/en-us/azure/developer/ansible/dynamic-inventory-configure?tabs=azure-cli)
* [ADO Ansible](https://theazureblog.co.uk/azure-devops-ansible)
* [ANSIBLE: BRING POWERSHELL OUTPUT INTO ANSIBLE VARIABLES](https://kmg.group/posts/2021-06-25-bring-powershell-output-to-ansible/)
* [Win_update results](https://www.reddit.com/r/ansible/comments/f6z6hv/win_update_results/)
* [ansible.windows.win_updates not applying cumulative updates correctly](https://github.com/ansible-collections/ansible.windows/issues/180)
* [Pipeline Variables](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/variables?view=azure-devops&tabs=yaml%2Cbatch)
* [Pipeline Conditions](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/conditions?view=azure-devops&tabs=yaml%2Cstages)
* [Azure Resource Manager inventory plugin](https://docs.ansible.com/ansible/latest/collections/azure/azcollection/azure_rm_inventory.html)
* [Ansible Commands Cheat sheet](https://docs.ansible.com/ansible/latest/command_guide/cheatsheet.html)
