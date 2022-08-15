#!/bin/bash

# Instructions followed from: https://www.pjrc.com/teensy/td_download.html

TEENSY_RULES=00-teensy.rules
TEENSYDUINO_INSTALLER=TeensyduinoInstall.linux64
ARDUINO_LOCATION=/opt
ARDUINO_VERSION=arduino-1.8.19
ARDUINO_TARBALL="$ARDUINO_VERSION"-linux64.tar.xz

## Download necessary files
wget https://www.pjrc.com/teensy/"$TEENSY_RULES"
wget https://www.pjrc.com/teensy/td_156/"$TEENSYDUINO_INSTALLER"
wget https://downloads.arduino.cc/"$ARDUINO_TARBALL"

## Install Teensy UDEV rules
sudo mv "$TEENSY_RULES" /etc/udev/rules.d/

## Install Arduino
if [ ! -d "$ARDUINO_LOCATION" ]
    then
    sudo mkdir -p "$ARDUINO_LOCATION"
fi
tar -xf "$ARDUINO_TARBALL"
sudo mv "$ARDUINO_VERSION" "$ARDUINO_LOCATION"/
sudo chown chris:chris "$ARDUINO_LOCATION"/"$ARDUINO_VERSION"
sudo "$ARDUINO_LOCATION"/"$ARDUINO_VERSION"/install.sh

## Install Teensyduino
chmod 755 "$TEENSYDUINO_INSTALLER"
./"$TEENSYDUINO_INSTALLER"

# Cleanup
rm "$TEENSYDUINO_INSTALLER" "$ARDUINO_TARBALL"
