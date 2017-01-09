#!/bin/bash

instlog="/home/vagrant/install.log"

##Check execution
if [ -e "/home/vagrant/complete" ]; then
  exit 0
else
  set -e
  trap 'echo Error!!' ERR

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
  echo "`date` Java 1.8 installed " >> $instlog

  ## Install ScaleIO
  #cd /vagrant
  if [ -e "/vagrant/ScaleIO_Linux_v2.0.zip" ]; then
      echo "`date` ScaleIO_Linux_v2.0.zip is founded " >> $instlog
  else
      echo "`date` ScaleIO will be downloaded " >> $instlog
      netbw=`tail -n 2 /home/vagrant/wget.log | sed -n 1p | cut -d " " -f 3 | cut -d "(" -f 2`
      dltime=`echo "1678 $netbw" | awk '{print $1 / $2}'`
      dltime2=`echo "$dltime 60" | awk '{print $1 / $2}'`
      ttdl=`echo "$dltime2 0.5" | awk '{printf("%d", $1 + $2)}'`
      echo "========== `date` =========="
      echo "ScaleIO is beeing downloaded. Please wait..."
      echo "It will take about $ttdl min on your environment."
      sudo wget -nv http://downloads.emc.com/emc-com/usa/ScaleIO/ScaleIO_Linux_v2.0.zip
      echo "`date` Download complete " >> $instlog
  fi
  sudo unzip -n /vagrant/ScaleIO_Linux_v2.0.zip -d /vagrant/scaleio/

  ## Install GW and IM
  dir=`ls /vagrant/scaleio`
  version=`echo $dir | cut -d "_" -f 2`
  echo "ScaleIO Version : $version"
  gwrpm=`find /vagrant -name *gateway*.rpm`
  GATEWAY_ADMIN_PASSWORD=Password123! rpm -i $gwrpm --nodeps
  echo "`date` ScaleIO GW-IM installed " >> $instlog
  echo "================================================="
  echo "====== Installation for TB complete!       ======"
  echo "====== You can access ScaleIO IM from host ======" 
  echo "====== URL https://127.0.0.1:4431 (or 4432)======"
  echo "====== Login User=admin, PW=Password123!   ======"
  echo "================================================="
  echo "`date`" > /home/vagrant/complete
fi
