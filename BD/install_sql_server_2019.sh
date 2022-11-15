sudo yum update
sudo yum install python2

sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/8/prod.repo
sudo yum install -y mssql-server
sudo /opt/mssql/bin/mssql-conf setup

sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/8/prod.repo
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc

wget -o /tmp/azure_data_studio.rpm https://go.microsoft.com/fwlink/?linkid=2204774 
sudo yum install /tmp/azure_data_studio.rpm