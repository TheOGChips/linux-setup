#!/bin/bash

pkg_mgr="$1"
sudo "$pkg_mgr" -y install git

git config --global user.name "TheOGChips"
git config --global user.email "swindell.christian.g@gmail.com"
git config --global credential.helper store
git config --global core.sshCommand "ssh -i ~/.ssh/github -F /dev/null"
