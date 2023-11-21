#!/bin/bash
pkg_mgr="$1"
alt_pkg_mgr="$2"

echo "\nThe following lines must be added from visudo AT THE END of the file:"
for cmd in "$pkg_mgr" "$alt_pkg_mgr" arp poweroff reboot ansible-playbook add-apt-repository
    do
    echo -e "\t$USER $HOSTNAME = (root) NOPASSWD: $(sudo which $cmd)"
done
echo -e "\nA terminal window under visudo will now launch. You will be taken to the editor after entering"
echo "your password. The terminal window will close automatically after you exit visudo."
sleep 5
konsole -e 'sudo visudo'
