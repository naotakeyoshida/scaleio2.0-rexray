#!/bin/bash

instlog="/home/vagrant/install.log"

##Check execution
if [ -e "/home/vagrant/complete" ]; then
    exit 0
else
    :
fi

## Install bash-completion
sudo yum install bash-completion -y

## Reset interface for CentOS7.2
sudo systemctl restart network

echo "`date` bash-completion was installed " >> $instlog
echo "================================================"
echo "======== Installation for MDM complete! ========"
echo "================================================"
echo "`date`" > /home/vagrant/complete
