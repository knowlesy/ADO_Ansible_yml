sudo mkdir /myagent 
cd /myagent
sudo wget https://vstsagentpackage.azureedge.net/agent/3.220.5/vsts-agent-linux-x64-3.220.5.tar.gz
sudo tar zxvf ./vsts-agent-linux-x64-3.220.5.tar.gz
sudo chmod -R 777 /myagent
runuser -l testadmin -c '/myagent/config.sh --unattended  --url https://dev.azure.com/<MyDevOpsOrg> --auth pat --token <MyDevOpsToken> --pool <MyDevOpsPool>'
udo /myagent/svc.sh install
sudo /myagent/svc.sh start
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible -y
sudo apt install python3-pip -y
pip install pywinrm[credssp]
pip install pywinrm --upgrade
sudo mkdir /usr/share/ansible/collections
ansible-galaxy collection install azure.azcollection -p /usr/share/ansible/collections
sudo pip3 install -r /usr/share/ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
exit 0