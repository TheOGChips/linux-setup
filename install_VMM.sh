#!/bin/bash
# A script to install Virtual Machine Manager, give "$USER" the correct permissions, and setup
# script to backup and restore VM images.

DEBIAN="debian bullseye"
FEDORA="fedora"
ROCKY="rocky"
distro="$1"
pkg_mgr="$2"

function set_default_pool {
    # Change default image storage pool: /var/lib/libvirt/images -> /media/$USER/Torchwood/vm_images
    filepath=/media/"$USER"/Torchwood/vm_images
    virsh pool-destroy default
    virsh pool-undefine default
    virsh pool-define-as --name default --type dir --target "$filepath"
    virsh pool-autostart default
    virsh pool-start default
    virsh pool-list
}

sudo "$pkg_mgr" -y install virt-manager
if [ "$distro" = "$DEBIAN" ]
    then
    # Help: https://linuxize.com/post/how-to-install-kvm-on-ubuntu-20-04/
    sudo rm `sudo find / -name '*remote-viewer*'` # Remove "Remote Viewer" (already have Remote
                                                  # Desktop Viewer)
    sudo addgroup "$USER" kvm       # Needed because VMM doesn't seem to play nice with default
    sudo addgroup "$USER" libvirt   # root access on Debian Bullseye
    #sudo sed -i "s;#user = \"root\";user = \"$USER\";" /etc/libvirt/qemu.conf

    #filepath=/var/lib/libvirt/images
    #sudo chmod o+r "$filepath"

    set_default_pool
    sudo systemctl restart libvirtd

elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    sudo "$pkg_mgr" -y install libvirt-client
    # src: https://unix.stackexchange.com/questions/269078/executing-a-bash-script-function-with-sudo
    sudo bash -c "$(declare -f set_default_pool); set_default_pool"
fi

echo -e '\nNOTE: You might need to restart your machine in order for virt-manager to work as expected\n'
