#!/bin/bash

JFLAP=JFLAP7.1.jar
wget "https://www.jflap.org/jflaptmp/july27-18/$JFLAP" #change URL as necessary
mv "$JFLAP" "$HOME"/.local/bin
echo "alias jflap='java -jar $HOME/.local/bin/$JFLAP'" >> "$HOME"/.bash_aliases
