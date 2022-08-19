#!/bin/bash

sudo dnf -y install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install discord onlyoffice rpi-imager teams #zoom slack stm32cubeide
sudo flatpak override com.discordapp.Discord --filesystem=home
sudo flatpak override com.microsoft.Teams --filesystem=home
