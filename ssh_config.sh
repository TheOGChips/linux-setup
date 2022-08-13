#!/bin/bash

#TODO: Create SSH keys for Raspberry Pi 4

SSH="$HOME"/.ssh
SSH_CONFIG="$SSH"/config

echo -e 'Generating key for Github...\n'
ssh-keygen -b 4096 -t ed25519 -f "$SSH"/github
echo -e 'Generating key for Gitlab...\n'
ssh-keygen -b 4096 -t ed25519 -f "$SSH"/gitlab

echo 'Host holley-physics' >> "$SSH_CONFIG"
echo '    HostName 149.149.18.14' >> "$SSH_CONFIG"
echo '    Port 33138' >> "$SSH_CONFIG"
echo "    IdentityFile $SSH/holley-physics" >> "$SSH_CONFIG"
echo -e 'Generating key for physics lab computer...\n'
ssh-keygen -b 4096 -t ed25519 -f "$SSH"/holley-physics
echo -e 'Copying public key to physics lab computer...\n'
ssh-copy-id -i "$SSH"/holley-physics cswindell@holley-physics

echo 'Host rpi4' >> "$SSH_CONFIG"
echo '    HostName 10.10.100.101' >> "$SSH_CONFIG"
echo "    IdentityFile $SSH/rpi4" >> "$SSH_CONFIG"
echo -e 'Generating key for Raspberry Pi 4...\n'
ssh-keygen -b 4096 -t ed25519 -f "$SSH"/rpi4
