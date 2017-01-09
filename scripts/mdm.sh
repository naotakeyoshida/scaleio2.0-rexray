#!/bin/sh

instlog="/home/vagrant/install.log"

##Check execution
if [ -e "/home/vagrant/complete" ]; then
  exit 0
else
  set -e
  trap 'echo Error!!' ERR

  ## Install common packages
  sh /vagrant/scripts/common.sh

  ## Install bash-completion
  sudo yum install bash-completion -y
  echo "`date` bash-completion installed " >> $instlog
  echo "================================================"
  echo "======== Installation for MDM complete! ========"
  echo "================================================"
  echo "`date`" > /home/vagrant/complete
fi
