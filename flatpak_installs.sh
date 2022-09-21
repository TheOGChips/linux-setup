#!/bin/bash

sudo dnf -y install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install discord onlyoffice rpi-imager teams qgis #zoom slack stm32cubeide

function flatpak_override {
    sudo flatpak override "$1" --filesystem=home
}

discord=com.discordapp.Discord
teams=com.microsoft.Teams
for remote in "$discord" "$teams"
    do
    flatpak_override "$remote"
done
