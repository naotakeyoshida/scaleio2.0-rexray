# ScaleIO2.0-REX-Ray

You can try [ScaleIO](https://japan.emc.com/storage/scaleio/index.htm) on VirtualBox using Vagrant. Also you can try Docker Volume Plugin "[REX-Ray](https://github.com/codedellemc/rexray)" under the ScaleIO environment. Original idea of this code is based on [{Code} by DellEMC](https://codedellemc.com/).
  
  
## Description
With this scripts, three VMs will be deployed. Those VMs will be configured as a cluster "swarm mode". ScaleIO which is a product of Software-Defined Strage released by DellEMC will provide block storage service for Docker. REX-Ray, running as a volume plugin, will be an end point of storage control for Docker and Swarm. Configurations of each VM are listed below.

Host name : tb 
- IP address : 192.168.33.11
- Software : Docker with swarm mode (Manager & Worker), ScaleIO (Tie-Breaker), REX-Ray

Host name : mdm1
- IP address : 192.168.33.12
- Software : Docker with swarm mode (Worker), ScaleIO (MDM), REX-Ray

host name : mdm2
- IP address : 192.168.33.13
- Software : Docker with swarm mode (Worker), ScaleIO (MDM), REX-Ray 
  
  
## Requirement
* Vagrant
* git
* VirtualBox
* VirtualBox Host Memory: over 3GB
  
  
## Usage
Using commands below, three VMs(RedHat7.2) will be created.  

1. `git clone https://github.com/naotakeyoshida/scaleio2.0-rexray.git`  
2. `cd scaleio2.0-rexray`  
  
If you want to create those VMs quickly, dowonload "ScaleIO Linux" file from [here](https://www.emc.com/products-solutions/trial-software-download/scaleio.htm). Then save the file into the directory "scaleio2.0-rexray". After that, execute command below.  

3. `vagrant up`  
4. Open Web Browser on your VirualBox host. Then access to ScaleIO Install Manager(IM) at "https://127.0.0.1:4431" (User:admin, Password:Password123!). 
5. After logged in to the IM, upload rpm package files of ScaleIO from `scaleio\ScaleIO_2.0.1.2_Complete_Linux_SW_Download\ScaleIO_2.0.1.2_RHEL_OEL7_Download` and upload a configuration file `ScaleIO_3Nodes_Config.csv`. Proceed ScaleIO installation using IM. Make sure push "Mark Complete" button after the installation completed.
  
After ScaleIO installation complete, login to the each of VMs. Then execute few commands below.
  
6. `vagrant ssh tb`
7. `[tb]$ sudo bash /vagrant/scripts/rexray-tb.sh`
8. `[tb]$ exit`
9. `vagrant ssh mdm1`
10. `[mdm1]$ sudo bash /vagrant/scripts/rexray-mdm.sh`
11. `[mdm1]$ exit`
12. `vagrant ssh mdm2`
13. `[mdm2]$ sudo bash /vagrant/scripts/rexray-mdm.sh`
14. `[mdm2]$ exit`

Now you can use Docker and REX-Ray commands.


## Author
naotakeyoshida
