#!/bin/bash
# Wine installation and setup

distro="$1"
#PREFIX="$HOME"/.wine32

if [ "$distro" = 'debian bullseye' ]
    then
    pkg_mgr=apt
    alt_pkg_mgr=dpkg
elif [ "$distro" = 'fedora' -o "$distro" = 'rocky' ]
    then
    pkg_mgr=dnf
    alt_pkg_mgr=rpm
fi

sudo "$pkg_mgr" -y install wine

if [ "$distro" = 'debian bullseye' ]
    then
    #sudo "$alt_pkg_mgr" --add-architecture i386
    #sudo "$pkg_mgr" -y install wine32
fi

wget https://ltspice.analog.com/software/LTspice64.exe

#WINEARCH=win32 WINEPREFIX="$PREFIX" winecfg
#echo "alias wine32='WINEPREFIX=$PREFIX wine'" >> "$HOME"/.bash_aliases
