#!/bin/bash
sleep 10s
instlog="/home/vagrant/install.log"

## Update
#sudo yum update -y
#echo "`date` Updated " >> $instlog

## Disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable firewalld
echo "`date` Stopped and disabled firewall service " >> $instlog

## Add yum repo
cd /etc/yum.repos.d/
sudo wget http://download.opensuse.org/repositories/Virtualization:Appliances/CentOS_CentOS-6/Virtualization:Appliances.repo
cd /home/vagrant
echo "`date` yum repo added" >> $instlog

## Install required packages
sudo yum install unzip numactl libaio wget openssl openldap hwinfo pciutils ethtool -y
echo "`date` required packages inlstalled " >> $instlog
