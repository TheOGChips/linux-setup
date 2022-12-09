#!/bin/bash
# A script to configure my setup of the Nano text editor

NANORC="$HOME"/.nanorc
echo > "$NANORC"

#NOTE: Will probably want 'functioncolor green' if using through SSH
echo -n > "$NANORC"
for setting in autoindent linenumbers smarthome 'tabsize 4' tabstospaces 'numbercolor brightcyan' 'titlecolor brightyellow' 'functioncolor blue' 'keycolor brightwhite'
    do
    echo "set $setting" >> "$NANORC"
done
echo 'include "/usr/share/nano/*.nanorc"' >> "$NANORC"
