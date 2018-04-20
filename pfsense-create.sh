#!/bin/bash

#The name it's going to be displayed as in VirtualBox
name="Automatized Pfsense"
#The type of operating system the VM needs
os='Linux_64'
#Size of the disk in Mbytes
size=10000
#The folder where the .iso file can be located
isofile='/home/user/pfSense-CE-2.4.2-RELEASE-amd64.iso'
#The folder where VirtualBox handles the files
filepath="$(echo ~)/VirtualBox VMs/"

VBoxManage createhd --filename "$filepath$name/$name.vdi" --size $size
VBoxManage createvm --basefolder "$filepath" --name "$name" --ostype $os --register
VBoxManage storagectl "$name" --name "IDE Controller" --add ide
VBoxManage storageattach "$name" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $isofile
VBoxManage storagectl "$name" --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach "$name" --storagectl "SATA Controller" --port 0  --device 0 --type hdd --medium "$filepath$name/$name.vdi"
VBoxManage modifyvm "$name" --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm "$name" --memory 1024 --vram 128
VBoxManage modifyvm "$name" --nic1 bridged --bridgeadapter1 enp2s0 --cableconnected1 on
VBoxManage modifyvm "$name" --nic2 hostonly --hostonlyadapter2 vboxnet1 --cableconnected2 on
VBoxManage startvm "$name"
