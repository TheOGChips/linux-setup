#!/bin/bash
# A script to setup ClusterSSH and all shortcuts for more convenient access to the Raspberry Pi cluster

BASH_ALIASES=~/.bash_aliases

# Raspberry Pi cluster tutorials:
# 1. Part 1 -> https://glmdev.medium.com/building-a-raspberry-pi-cluster-784f0df9afbd
#	 Part 2 -> https://glmdev.medium.com/building-a-raspberry-pi-cluster-aaa8d1f3d2ca
#	 Part 3 -> https://glmdev.medium.com/building-a-raspberry-pi-cluster-f5f2446702e8
# 2. https://magpi.raspberrypi.org/articles/build-a-raspberry-pi-cluster-computer

# Aliases to SSH into each of the Raspberry Pi cluster nodes
# Ethernet IP addresses for each Raspberry Pi
master=10.10.10.0
node1=10.10.10.1
node2=10.10.10.2
node3=10.10.10.3
node4=10.10.10.4
node5=10.10.10.5
node6=10.10.10.6
node7=10.10.10.7

# Using Ethernet
echo "alias clusterphuq0-ssh-eth='ssh pi@$master'" >> "$BASH_ALIASES"
echo "alias clusterphuq1-ssh-eth='ssh pi@$node1'" >> "$BASH_ALIASES"
echo "alias clusterphuq2-ssh-eth='ssh pi@$node2'" >> "$BASH_ALIASES"
echo "alias clusterphuq3-ssh-eth='ssh pi@$node3'" >> "$BASH_ALIASES"
echo "alias clusterphuq4-ssh-eth='ssh pi@$node4'" >> "$BASH_ALIASES"
echo "alias clusterphuq5-ssh-eth='ssh pi@$node5'" >> "$BASH_ALIASES"
echo "alias clusterphuq6-ssh-eth='ssh pi@$node6'" >> "$BASH_ALIASES"
echo "alias clusterphuq7-ssh-eth='ssh pi@$node7'" >> "$BASH_ALIASES"

# Using Wi-Fi
#echo "alias clusterphuq0-ssh-wifi='ssh pi@10.255.160.28'" >> "$BASH_ALIASES"
#echo "alias clusterphuq1-ssh-wifi='ssh pi@10.255.160.34'" >> "$BASH_ALIASES"
#echo "alias clusterphuq2-ssh-wifi='ssh pi@10.255.163.191'" >> "$BASH_ALIASES"
#echo "alias clusterphuq3-ssh-wifi='ssh pi@10.255.163.164'" >> "$BASH_ALIASES"
#echo "alias clusterphuq4-ssh-wifi='ssh pi@10.255.163.231'" >> "$BASH_ALIASES"
#echo "alias clusterphuq5-ssh-wifi='ssh pi@10.255.163.224'" >> "$BASH_ALIASES"
#echo "alias clusterphuq6-ssh-wifi='ssh pi@10.255.161.240'" >> "$BASH_ALIASES"
#echo "alias clusterphuq7-ssh-wifi='ssh pi@10.255.161.235'" >> "$BASH_ALIASES"
