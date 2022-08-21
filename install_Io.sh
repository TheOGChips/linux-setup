#!/bin/bash

DEBIAN="debian bullseye"
FEDORA="fedora"
ROCKY="rocky"
distro="$1"
pkg_mgr="$2"
if [ "$distro" = "$DEBIAN" ]
    then
    pkg_type=deb

elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    pkg_type=rpm
fi

archive=iobin-linux-x64-"$pkg_type"-current.zip
wget http://iobin.suspended-chord.info/linux/"$archive"
unzip "$archive"
sudo "$pkg_mgr" -y install ./IoLanguage*."$pkg_type"
rm license.txt README.txt "$archive" IoLanguage*."$pkg_type"
