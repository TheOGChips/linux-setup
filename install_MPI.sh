#!/bin/bash

DEBIAN="debian bullseye"
FEDORA="fedora"
ROCKY="rocky"
distro="$1"
pkg_mgr="$2"

if [ "$distro" = "$DEBIAN" ]
    then
    sudo "$pkg_mgr" -y install openmpi-bin openmpi-common libopenmpi3 libopenmpi-dev   # OpenMPI
elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    sudo "$pkg_mgr" -y install openmpi openmpi-devel
    echo 'source /etc/profile.d/modules.sh' >> "$HOME"/.zshrc
    echo 'module load mpi/openmpi-x86_64' >> "$HOME"/.zshrc
fi
