#!/bin/bash

instlog="/home/vagrant/install.log"

## Docker install
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
echo "`date` yum repo for Docker was added" >> $instlog
yum install -y docker-engine
sudo systemctl enable docker.service
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo systemctl start docker
echo "`date` Docker installed " >> $instlog
echo "Docker installation complete!"

## Set ScaleIO system name
pdomain="pdomain1"
stpool="pool1"
sysname="scaleio"
endpoint="https://192.168.33.12/api"
password="Password123!"
thin="ThinProvisioned"
pmdm=`scli --login --mdm_ip 192.168.33.13 --username admin --password "Password123!" --approve_certificate`
if [ $? = 0 ]; then
  mdmip="192.168.33.13"
else
  mdmip="192.168.33.12"
fi
echo "========================================"
echo " Primary MDM is $mdmip "
echo "========================================"
scli --login --mdm_ip $mdmip --username admin --password $password --approve_certificate
output=`scli --mdm_ip $mdmip --query_all |grep Name`
set -- $output
now=$2
snamenow=${now[0]}
if [ $snamenow = scaleio ]; then
  echo "The system name is $snamenow ."
else
  echo "The system name is $snamenow ."
  scli --mdm_ip $mdmip --rename_system --new_name $sysname
  echo "The system name has been set as $sysname ."
fi

## Install Rexray
sudo curl -sSL https://dl.bintray.com/emccode/rexray/install | sh -s -- stable
sudo cat << EOF > /etc/rexray/config.yml
libstorage:
  service: scaleio

scaleio:
  endpoint: $endpoint
  insecure: true
  userName: admin
  password: $password
  systemName: $sysname
  protectionDomainName: $pdomain
  storagePoolName: $stpool
  thinOrThick: $thin
EOF
echo "`date` RexRay was installed and configured " >> $instlog
sudo service rexray restart
sudo service rexray status
sudo service docker restart
echo "==========================================="
echo " Docker and REX-Ray installation complete! "
echo "==========================================="

## Initial setup of Swarm
echo "Docker Swarm initialized..."
echo "  "
master=192.168.33.11
docker swarm init --listen-addr $master:2377 --advertise-addr $master
docker swarm join-token worker > /vagrant/token.txt
echo "==========================="
echo " This node set as a master."
echo "==========================="
