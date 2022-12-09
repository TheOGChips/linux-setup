#!/bin/bash

SSH="$HOME"/.ssh
SSH_CONFIG="$SSH"/config

key="$SSH"/github
if [ ! -f "$key" ]
    then
    echo -e 'Generating key for Github...\n'
    ssh-keygen -b 4096 -t ed25519 -f "$key"
fi

key="$SSH"/gitlab
if [ ! -f "$key" ]
    then
    echo -e 'Generating key for Gitlab...\n'
    ssh-keygen -b 4096 -t ed25519 -f "$key"
fi

remote=TTU-Physics-ATHolley
key="$SSH"/"$remote"
if [ ! -f "$key" ]
    then
    echo "Host $remote" >> "$SSH_CONFIG"
    echo '    HostName 149.149.18.14' >> "$SSH_CONFIG"
    echo '    Port 33138' >> "$SSH_CONFIG"
    echo "    IdentityFile $SSH/$remote" >> "$SSH_CONFIG"
    echo -e 'Generating key for physics lab computer...\n'
    ssh-keygen -b 4096 -t ed25519 -f "$key"
    echo -e 'Copying public key to physics lab computer...\n'
    ssh-copy-id -i "$SSH"/"$remote" cswindell@"$remote"
fi

remote=rpi4
key="$SSH"/"$remote"
if [ ! -f "$key" ]
    then
    echo "Host $remote" >> "$SSH_CONFIG"
    echo '    HostName 10.10.100.101' >> "$SSH_CONFIG"
    echo "    IdentityFile $key" >> "$SSH_CONFIG"
    echo -e 'Generating key for Raspberry Pi 4...\n'
    ssh-keygen -b 4096 -t ed25519 -f "$key"
fi

remote=debian-vm
key="$SSH"/"$remote"
if [ ! -f "$key" ]
    then
    echo "Host $remote" >> "$SSH_CONFIG"
    echo '    HostName 192.168.122.224' >> "$SSH_CONFIG"
    echo "    IdentityFile $key" >> "$SSH_CONFIG"
    echo -e 'Generating key for Debian VM...\n'
    ssh-keygen -b 4096 -t ed25519 -f "$key"
fi

remote=debian_chroot
key="$SSH"/"$remote"
if [ ! -f "$key" ]
    then
    echo "Host $remote" >> "$SSH_CONFIG"
    echo '    HostName localhost' >> "$SSH_CONFIG"
    echo '    Port 2222' >> "$SSH_CONFIG"
    echo "    IdentityFile $key" >> "$SSH_CONFIG"
    echo -e 'Generating key for local chroot jail...\n'
    ssh-keygen -b 4096 -t ed25519 -f "$key"
fi
