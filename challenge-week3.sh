#!/bin/bash

resourcegroup1=$1
vmdisk1=$2
vm1=$3
adminusername1=$4
snapshotname1=$5
copy_vmdisk1=$6
##ip=$5

azgroupresult="$( az group list --query [].name | grep -E $resourcegroup1 )"
## see if resourcegroup doesnt exists, create resourcegroup 
if [ -z $azgroupresult ]; then
az group create -n $resourcegroup1 -l southcentralus
exit 1
fi

## then create disk
az disk create -g $resourcegroup1 -n $vmdisk1 --size-gb 30

## then attach that disk while creating vm
az vm create -g $resourcegroup1 -n $vm1 --attach-data-disks $vmdisk1 --admin-username $adminusername1 --custom-data './init-vm.txt' --image UbuntuLTS --generate-ssh-keys

## then log into vm
id=$( az vm show -g resourcegroup1 -n $vm1 -d --query [].publicIps | grep -E $ip )
adminusername=$( az vm show -g $rg -n $vm1 -d --query [].name | grep -E $adminusername1 )

ssh $adminusername1@$id

## then create media dir for the vmdisk1 for mounting
sudo mkdir /media/$vmdisk1
sudo mount /dev/sdc /media/$vmdisk1
sudo mv server.js /media/$vmdisk1/server.js
exit

