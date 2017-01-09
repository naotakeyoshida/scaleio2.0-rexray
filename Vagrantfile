# -*- mode: ruby -*-
# vi: set ft=ruby :

siodev1 = './device/siodev1.vdi'
siodev2 = './device/siodev2.vdi'
siodev3 = './device/siodev3.vdi'

Vagrant.configure(2) do |config|
  config.vm.box = "bento/centos-7.2"
  config.vm.define "tb" do |centos72|
      centos72.vm.hostname = "tb.local"
      centos72.vm.synced_folder ".", "/vagrant"
      centos72.vm.network "forwarded_port", guest: 22, host: 2221
      centos72.vm.network "forwarded_port", guest: 443, host: 4431
      centos72.vm.network "private_network", ip: "192.168.33.11"
      centos72.vm.provider "virtualbox" do |vb|
          vb.name = "tb"
          vb.customize ["modifyvm", :id, "--memory", 3072]
          vb.customize ['createhd', '--filename', siodev1, '--size', 100 * 1024]
          vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', siodev1]
      end
      centos72.vm.provision :shell do |shell|
              shell.path = "scripts/tb.sh"
      end 
  end
  config.vm.define "mdm1" do |centos72|
      centos72.vm.hostname = "mdm1.local"
      centos72.vm.synced_folder ".", "/vagrant"
      centos72.vm.network "forwarded_port", guest: 22, host: 2222
      centos72.vm.network "forwarded_port", guest: 6611, host: 6611
      centos72.vm.network "private_network", ip: "192.168.33.12"
      centos72.vm.provider "virtualbox" do |vb|
          vb.name = "mdm1"
	  vb.customize ["modifyvm", :id, "--memory", 1024]
	  vb.customize ['createhd', '--filename', siodev2, '--size', 100 * 1024]
	  vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', siodev2]
      end
      centos72.vm.provision :shell do |shell|
          shell.path = "scripts/mdm.sh"
      end
  end
  config.vm.define "mdm2" do |centos72|
      centos72.vm.hostname = "mdm2.local"
      centos72.vm.synced_folder ".", "/vagrant"
      centos72.vm.network "forwarded_port", guest: 22, host: 2223
      centos72.vm.network "forwarded_port", guest: 6611, host: 6612
      centos72.vm.network "private_network", ip: "192.168.33.13"
      centos72.vm.provider "virtualbox" do |vb|
          vb.name = "mdm2"
          vb.customize ["modifyvm", :id, "--memory", 1024]
	  vb.customize ['createhd', '--filename', siodev3, '--size', 100 * 1024]
	  vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', siodev3]
      end
      centos72.vm.provision :shell do |shell|
          shell.path = "scripts/mdm.sh"
      end
  end
  config.vm.provision :shell, path: "scripts/bootstrap.sh"
end
