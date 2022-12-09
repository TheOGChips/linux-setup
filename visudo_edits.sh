#!/bin/bash
pkg_mgr="$1"
alt_pkg_mgr="$2"
ALIASES="$3"

echo "\nThe following lines must be added from visudo AT THE END of the file:"
for cmd in "$pkg_mgr" "$alt_pkg_mgr" arp poweroff reboot
    do
    echo -e "\t$USER $HOSTNAME = (root) NOPASSWD: $(sudo which $cmd)"
    echo "alias "$cmd"='sudo $cmd'" >> "$ALIASES"
done
echo -e "\nA terminal window under visudo will now launch. You will be taken to the editor after entering"
echo "your password. The terminal window will close automatically after you exit visudo."
sleep 1 # TODO: Return this to 5 after debugging is done
#konsole -e 'sudo visudo'
