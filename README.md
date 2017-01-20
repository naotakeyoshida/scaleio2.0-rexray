# ScaleIO2.0-REX-Ray

You can try [ScaleIO](https://japan.emc.com/storage/scaleio/index.htm) on VirtualBox using Vagrant. Also you can try Docker Volume Plugin "[REX-Ray](https://github.com/codedellemc/rexray)" under the ScaleIO environment. Original idea of this code is based on [{Code} by DellEMC](https://codedellemc.com/).
  
  
## Description
ScaleIO is a product of Software-Defined Strage released by DellEMC.
  
  
## Requirement
* Vagrant 
* VirtualBox
* VirtualBox Host Memory: over 3GB
  
  
## Usage
Using commands below, three VMs(RedHat7.2) will be created.  

1. `git clone https://github.com/naotakeyoshida/scaleio2.0-rexray.git`  
2. `cd scaleio2.0-rexray`  
  
If you want to create those VMs quickly, dowonload "ScaleIO Linux" file from [here](https://www.emc.com/products-solutions/trial-software-download/scaleio.htm). Then save the file into the directory "scaleio2.0-rexray". After that, execute command below.  

3. `vagrant up`  
4. Open Web Browser on your VirualBox host. Then access to ScaleIO Install Manager(IM) at "https://127.0.0.1:4431" (User:admin, Password:Password123!). 
5. After logged into the IM, upload rpm package files of ScaleIO from `scaleio\ScaleIO_2.0.1.2_Complete_Linux_SW_Download\ScaleIO_2.0.1.2_RHEL_OEL7_Download` and upload a configuration file `ScaleIO_3Nodes_Config.csv`. Proceed ScaleIO installation using IM. Make sure push "Mark Complete" button after the installation completed.
  
After ScaleIO installation complete, login to the each of VMs. Then execute few commands below.
  
6. `vagrant ssh tb`
7. `[tb]$ sudo /vagrant/scripts/rexray.sh`
8. `[tb]$ exit`
9. `vagrant ssh mdm1`
10. `[mdm1]$ sudo /vagrant/scripts/rexray.sh`
11. `[mdm1]$ exit`
12. `vagrant ssh mdm2`
13. `[mdm2]$ sudo /vagrant/scripts/rexray.sh`
14. `[mdm2]$ exit`
  
## Author
naotakeyoshida
