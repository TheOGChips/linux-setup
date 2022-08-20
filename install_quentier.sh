#!/bin/bash

DEBIAN="debian bullseye"
FEDORA="fedora"
ROCKY="rocky"
distro="$1"
pkg_mgr="$2"

if [ "$distro" = "$DEBIAN" ]
    then
    # NOTE: Some extra steps required to install on Debian Bullseye
    echo 'deb http://download.opensuse.org/repositories/home:/d1vanov:/quentier-master/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/home:d1vanov:quentier-master.list
    curl -fsSL https://download.opensuse.org/repositories/home:d1vanov:quentier-master/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_d1vanov_quentier-master.gpg > /dev/null
    sudo "$pkg_mgr" update
    sudo "$pkg_mgr" install quentier-qt5

elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    # NOTE: Quentier is in Fedora's repository (Fedora 36)
    sudo "$pkg_mgr" install quentier
fi
