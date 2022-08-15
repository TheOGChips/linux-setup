#!/bin/bash
# Installation of Vivi screen sharing application for school

distro="$1"
pkg_ext="$2"

PKG=vivi."$pkg_ext"
wget https://api.vivi.io/"$pkg_ext" -O "$PKG"

if [ "$distro" = "debian bullseye" ]
    then
    sudo apt -y install ./"$PKG"
elif [ "$distro" = "fedora" -o "$distro" = "rocky" ]
    then
    sudo rpm --install ./"$PKG"
fi
rm "$PKG"
