#!/bin/bash

## Check execution 
test -f /home/vagrant/ok && exit

## Add node list to hosts
sudo -- sh -c "echo '192.168.33.11   tb.local tb' >> /etc/hosts"
sudo -- sh -c "echo '192.168.33.12   mdm1.local mdm1' >> /etc/hosts"
sudo -- sh -c "echo '192.168.33.13   mdm2.local mdm2' >> /etc/hosts"

## Set timezone
sudo cp /usr/share/zoneinfo/Japan /etc/localtime

## Fingerprint for next boot
date > /home/vagrant/ok
