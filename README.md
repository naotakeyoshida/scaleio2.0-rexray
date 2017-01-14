# ScaleIO2.0-REX-Ray

You can try [ScaleIO](https://japan.emc.com/storage/scaleio/index.htm) on VirtualBox using Vagrant. Also you can try Docker Volume Plugin "[REX-Ray](https://github.com/codedellemc/rexray)" under the ScaleIO environment. Original idea of this code is based on [{Code DellEMC}](https://codedellemc.com/).
  
  
## Description
ScaleIO is a product of Software-Defined Strage released by DellEMC.
  
  
## Requirement
* Vagrant 
* VirtualBox
* VirtualBox Host Memory: over 3GB
  
  
## Usage
Using command below, three VMs(RedHat7.2) will be created.  
1. `git clone https://github.com/naotakeyoshida/scaleio2.0-rexray.git`  
2. `cd scaleio2.0-rexray`  
  
If you want to install quickly, dowonload "ScaleIO 2.0" file from here. Then save the file into the directory "scaleio2.0-rexray". After that, execute command below.
  
3. `vagrant up`  
  
  
## Author
naotakeyoshida
