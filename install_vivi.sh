#!/bin/bash
# Installation of Vivi screen sharing application for school

PKG=vivi.deb
wget https://api.vivi.io/deb -O "$PKG"
sudo apt -y install ./"$PKG"
rm "$PKG"
