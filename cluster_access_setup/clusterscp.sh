#!/bin/bash

user=pi
master=10.10.10.0
node1=10.10.10.1
node2=10.10.10.2
node3=10.10.10.3
node4=10.10.10.4
node5=10.10.10.5
node6=10.10.10.6
node7=10.10.10.7

# $1 -> src file to transfer
# $2 -> transfer dest
scp "$1" "$user"@"$master":"$2"
scp "$1" "$user"@"$node1":"$2"
scp "$1" "$user"@"$node2":"$2"
scp "$1" "$user"@"$node3":"$2"
scp "$1" "$user"@"$node4":"$2"
scp "$1" "$user"@"$node5":"$2"
scp "$1" "$user"@"$node6":"$2"
scp "$1" "$user"@"$node7":"$2"
