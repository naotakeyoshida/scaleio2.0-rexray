#!/bin/bash

instlog="/home/vagrant/install.log"

##Check execution
if [ -e "/home/vagrant/complete" ]; then
  exit 0
else
  set -e
  trap 'echo Error!!' ERR


  ## Install bash-completion
  sudo yum install bash-completion -y
  echo "`date` bash-completion was installed " >> $instlog
  echo "================================================"
  echo "======== Installation for MDM complete! ========"
  echo "================================================"
  echo "`date`" > /home/vagrant/complete
fi
