#!/bin/bash

##Check execution
if [ -e "/home/vagrant/complete" ]; then
    exit 0
else
    :
fi

instlog="/home/vagrant/install.log"

## Download ScaleIO
cd /vagrant
if [ -e "/vagrant/ScaleIO_Linux_v2.0.zip" ]; then
    echo "`date` ScaleIO_Linux_v2.0.zip is founded " >> $instlog
else
    echo "`date` ScaleIO will be downloaded " >> $instlog
    echo "========== `date` =========="
    echo "ScaleIO is beeing downloaded. Please wait..."
    echo "It will take over 10 min."
    sudo wget -nv http://downloads.emc.com/emc-com/usa/ScaleIO/ScaleIO_Linux_v2.0.zip
    echo "`date` Download complete " >> $instlog
fi
sudo unzip -n /vagrant/ScaleIO_Linux_v2.0.zip -d /vagrant/scaleio/

## Reset interface for CentOS7.2
sudo systemctl restart network

echo "`date` ScaleIO GW-IM was installed " >> $instlog
echo "================================================="
echo "====== Installation for TB complete!       ======"
echo "====== You can access ScaleIO IM from host ======" 
echo "====== URL https://127.0.0.1:4431          ======"
echo "====== Login User=admin, PW=Password123!   ======"
echo "================================================="
echo "`date`" > /home/vagrant/complete
