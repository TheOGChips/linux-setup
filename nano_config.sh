#!/bin/bash
# A script to configure my setup of the Nano text editor

NANORC=~/.nanorc
echo 'set autoindent' >> "$NANORC"
echo 'set linenumbers' >> "$NANORC"
echo 'set smarthome' >> "$NANORC"
echo 'set tabsize 4' >> "$NANORC"
echo 'set tabstospaces' >> "$NANORC"
echo 'set numbercolor brightcyan' >> "$NANORC"
echo 'set titlecolor brightyellow' >> "$NANORC"
echo 'set functioncolor blue' >> "$NANORC"	# Will probably want green if using through SSH
echo 'set keycolor brightwhite' >> "$NANORC"
echo 'include "/usr/share/nano/*.nanorc"' >> "$NANORC"
