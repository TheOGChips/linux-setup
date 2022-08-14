#!/bin/bash
# Installs the VMware Horizon Linux client

# NOTE: Will need to update version number periodically
# NOTE: Can be uninstalled using guidance from the below link
#           -> https://askubuntu.com/questions/132779/how-to-delete-program-installed-with-bundle
vmware_horizon=vmware_horizon_client_x64.bundle
wget https://download3.vmware.com/software/view/viewclients/CART22FH2/VMware-Horizon-Client-2111-8.4.0-18957622.x64.bundle -O "$vmware_horizon"
chmod a+x "$vmware_horizon"
sudo ./"$vmware_horizon"
rm "$vmware_horizon"

