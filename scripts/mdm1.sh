#!/bin/bash

##Check execution
if [ -e "/home/vagrant/complete" ]; then
    exit 0
else
:
fi

instlog="/home/vagrant/install.log"

## Install bash-completion
sudo yum install bash-completion -y

## Install Java 1.8
cd /vagrant 
if [ -e "/vagrant/jre-8u60-linux-x64.rpm" ]; then
    echo "`date` jre-8u60 was founded " >> $instlog
else
    echo "JRE is beeing downloaded. Please wate..."
    sudo wget --no-cookies --no-check-certificate --header \
        "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
        "http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.rpm" -a /home/vagrant/wget.log
fi
sudo yum localinstall jre-8u60-linux-x64.rpm -y
echo "`date` Java 1.8 was installed " >> $instlog

## Install ScaleIO GW and IM
dir=`ls /vagrant/scaleio`
version=`echo $dir | cut -d "_" -f 2`
echo "ScaleIO Version : $version"
gwrpm=`find /vagrant -name *gateway*.rpm`
GATEWAY_ADMIN_PASSWORD=Password123! rpm -i $gwrpm --nodeps

## Reset interface for CentOS7.2
sudo systemctl restart network

echo "`date` bash-completion was installed " >> $instlog
echo "================================================"
echo "======== Installation for MDM complete! ========"
echo "================================================"
echo "`date`" > /home/vagrant/complete
