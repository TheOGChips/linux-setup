#!/bin/bash
# A script to install Virtual Machine Manager, give "$USER" the correct permissions, and setup
# script to backup and restore VM images.

DEBIAN="debian bullseye"
FEDORA="fedora"
ROCKY="rocky"
distro="$1"
pkg_mgr="$2"

sudo "$pkg_mgr" -y install virt-manager
if [ "$distro" = "$DEBIAN" ]
    then
    # NOTE: From what I've seen so far, this section doesn't look like it needs to be done on
    #       Fedora. Will change later if necessary.
    # Help: https://linuxize.com/post/how-to-install-kvm-on-ubuntu-20-04/
    sudo rm `sudo find / -name '*remote-viewer*'` # Remove "Remote Viewer" (already have Remote Desktop Viewer)
    sudo addgroup "$USER" kvm
    sudo addgroup "$USER" libvirt
    #sudo sed -i "s;#user = \"root\";user = \"$USER\";" /etc/libvirt/qemu.conf

    #filepath=/var/lib/libvirt/images
    #sudo chmod o+r "$filepath"

    # TODO: Confirm whether this section needs to be done on Rocky/Fedora as well
    # Change default image storage pool: /var/lib/libvirt/images -> /media/$USER/Torchwood/vm_images
    filepath=/media/"$USER"/Torchwood/vm_images
    virsh pool-destroy default
    virsh pool-undefine default
    virsh pool-define-as --name default --type dir --target "$filepath"
    virsh pool-autostart default
    virsh pool-start default
    virsh pool-list

    sudo systemctl restart libvirtd

#elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
#    then

fi

echo -e '\nNOTE: You might need to restart your machine in order for virt-manager to work as expected\n'
