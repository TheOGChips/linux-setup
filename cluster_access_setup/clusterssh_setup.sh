#!/bin/bash
# A script to setup ClusterSSH and all shortcuts for more convenient access to the Raspberry Pi cluster

BASH_ALIASES=~/.bash_aliases

# Each of the Raspberry Pi Ethernet IP addresses
master=10.10.10.0
node1=10.10.10.1
node2=10.10.10.2
node3=10.10.10.3
node4=10.10.10.4
node5=10.10.10.5
node6=10.10.10.6
node7=10.10.10.7

# ClusterSSH
sudo apt -y install clusterssh
filepath=~/.clusterssh/config
echo
echo -e "\ncssh will now be called to create $filepath. Just exit out of it.\n"
cssh	# creates ~/.clusterssh/config
sed -i "s;#comms=ssh;comms=ssh;" "$filepath"
sed -i "s;#user=;user=pi;" "$filepath"
sed -i "s;#terminal_reserve_bottom=0;terminal_reserve_bottom=25;" "$filepath"
#sed -i "s;#terminal_reserve_right=0;terminal_reserve_right=-5;" "$filepath"
sed -i "s;#screen_reserve_right=0;screen_reserve_right=1024;" "$filepath"	# 4:3 monitor is 1024x768
#sed -i "s;#screen_reserve_right=0;screen_reserve_right=1440;" "$filepath"	# 16:10 monitor is 1440x900
echo >> "$filepath"
echo "clusters = default" >> "$filepath"
echo "default = $master $node1 $node2 $node3 $node4 $node5 $node6 $node7" >> "$filepath"
echo
