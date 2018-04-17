#!/bin/bash

name="Automatized Build"
os='Ubuntu_64'
sizeDisk=20000
isofile='/home/sis/ubuntuserver.iso'
filepath="$(echo ~)/VirtualBox VMs/"

VBoxManage createhd --filename "$filepath$name/$name.vdi" --size $sizeDisk
VBoxManage createvm --basefolder "$filepath" --name "$name" --ostype $os --register
VBoxManage storagectl "$name" --name "IDE Controller" --add ide
VBoxManage storageattach "$name" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $isofile
VBoxManage storagectl "$name" --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach "$name" --storagectl "SATA Controller" --port 0  --device 0 --type hdd --medium "$filepath$name/$name.vdi"
VBoxManage modifyvm "$name" --boot1 dvd --boot2 disk --boot3 none --boot4 none
VBoxManage modifyvm "$name" --memory 2048 --vram 128
VBoxManage modifyvm "$name" --nic1 bridged --bridgeadapter1 enp2s0 --cableconnected1 on
VBoxManage startvm "$name"
