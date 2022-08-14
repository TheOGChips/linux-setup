#!/bin/bash
# A script to install Virtual Machine Manager, give "$USER" the correct permissions, and setup script to
# backup and restore VM images.

BASH_ALIASES=~/.bash_aliases

# Help: https://linuxize.com/post/how-to-install-kvm-on-ubuntu-20-04/
sudo apt -y install virt-manager
sudo rm `sudo find / -name '*remote-viewer*'` # Remove "Remote Viewer" (already have Remote Desktop Viewer)
sudo addgroup "$USER" kvm
sudo addgroup "$USER" libvirt
#sudo sed -i "s;#user = \"root\";user = \"$USER\";" /etc/libvirt/qemu.conf

#filepath=/var/lib/libvirt/images
#sudo chmod o+r "$filepath"

# Change default image storage pool: /var/lib/libvirt/images -> /media/$USER/Torchwood/vm_images
filepath=/media/"$USER"/Torchwood/vm_images
virsh pool-destroy default
virsh pool-undefine default
virsh pool-define-as --name default --type dir --target "$filepath"
virsh pool-autostart default
virsh pool-start default
virsh pool-list

sudo systemctl restart libvirtd
# NOTE: Will need to reboot in order to use virt-manager as regular user (if above line doesn't work)
