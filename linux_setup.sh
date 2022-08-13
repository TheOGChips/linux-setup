#!/bin/bash

READING_TIME=2
BASH_ALIASES="$HOME"/.bash_aliases
ZSH_ALIASES="$HOME"/.zsh_aliases
ALIASES="$ZSH_ALIASES"
ln -s "$ZSH_ALIASES" "$BASH_ALIASES"

if [ "$1" = "debian" ]
    then
    pkg_mgr=apt
    alt_pkg_mgr=dpkg
elif [ "$1" = "fedora" ]
    then
    pkg_mgr=dnf
    alt_pkg_mgr=rpm
elif [ "$1" = "" ]
    then
    echo 'Remember to enter a distribution name for this script to work'
    exit -1
else
    echo 'That distribution is currently unsupported'
fi

sudo "$pkg_mgr" update
sudo "$pkg_mgr" upgrade

function install_pkg {
    sudo "$pkg_mgr" -y install "$*"
}

function rm_pkg {
    sudo "$pkg_mgr" -y remove "$*"
}

# Remove unwanted packages
echo -e '\nRemoving unwanted packages...\n'
sleep "$READING_TIME"
rm_pkg akonadi-import-wizard akregator dragon elisa-player kgpg kmail kmines kmousetool kmouth kolourpaint
rm_pkg konversation krdc krfb kwrite libreoffice-core
#TODO: Add differences for Debian

# Make edits to the sudoers file
bash visudo_edits.sh
echo "alias su='sudo su'" >> "$HOME"/.zsh_aliases

# Update GRUB menu timeout
echo -e '\nUpdating GRUB menu timeout...\n'
sleep "$READING_TIME"
echo "alias update-grub='sudo grub2-mkconfig -o /boot/grub2/grub.cfg'" >> "$ALIASES"
sudo sed -i 's;GRUB_TIMEOUT=5;GRUB_TIMEOUT=-1;' /etc/default/grub

# Configure Nano
echo -e '\nConfiguring nano...\n'
sleep "$READING_TIME"
bash nano_config.sh

# Configure SSH
echo -e '\nConfiguring SSH...\n'
sleep "$READING_TIME"
bash ssh_config.sh

# Install desired packages
echo -e '\nInstalling packages...\n'
sleep "$READING_TIME"
rpm -Uvh http://download1.rpmfusion.org/free/fedora/rmpfusion-free-release-stable.noarch.rpm
install_pkg neofetch kate gnote vinagre java-latest-openjdk ffmpeg-free virt-manager gcc-c++ openmpi
install_pkg mingw{32,64}-gcc-c++ quentier ksudoku kmahjongg knights kpat python2.7 python3-pip gimp
install_pkg simplescreenrecorder ruby ruby-doc clojure gprolog gprolog-docs racket racket-doc htop vim
install_pkg vim-fugitive tree doxygen clang nasm julia julia-doc gimp-heif-plugin screen texstudio dmg2img
install_pkg cmatrix sl thefuck zsh plasma-browser-integration
#install_pkg rstudio-desktop ddd debootstrap
#TODO: Will need to fix virt-manager later (possibly look into qt-virt-manager
#TODO: Might need to install something else to get OpenMP to work with Clang

# Create local binaries directory
echo -e '\nCreating local app directories...\n'
sleep "$READING_TIME"
LOCAL="$HOME"/.local
mkdir "$LOCAL"/{bin,include}
mkdir "$LOCAL"/share/{gnote,vinagre}

# Install and configure Git
echo -e '\nInstalling and configuring Git...\n'
sleep "$READING_TIME"
bash git_config.sh "$pkg_mgr"

# Add local directories to C/C++ compiler paths
echo -e '\nAdding local paths to C/C++ compiler search paths...\n'
sleep "$READING_TIME"
PROFILE="$HOME"/.profile
mkdir "$PROFILE"
INCLUDE="$HOME"/.local/include
echo >> "$PROFILE"
echo "C_INCLUDE_PATH=$INCLUDE:$C_INCLUDE_PATH" >> "$PROFILE"
echo "CPLUS_INCLUDE_PATH=$INCLUDE:$CPLUS_INCLUDE_PATH" >> "$PROFILE"
echo 'export C_INCLUDE_PATH' >> "$PROFILE"
echo 'export CPLUS_INCLUDE_PATH' >> "$PROFILE"
echo >> "$PROFILE"

#TODO: Installing stuff for the Raspberry Pi cluster

# Install JFLAP
echo -e '\nInstalling JFLAP...\n'
sleep "$READING_TIME"
JFLAP=JFLAP7.1.jar
wget "https://www.jflap.org/jflaptmp/july27-18/$JFLAP" #change URL as necessary
mv "$JFLAP"
echo "alias jflap='java -jar $HOME/.local/bin/$JFLAP'" >> "$ALIASES"

# Set up Windows C/C++ compilation environment
sleep "$READING_TIME"
echo -e '\nSetting up Windows C/C++ cross-compilation...\n'
echo "alias win64g++='x86_64-w64-mingw32-g++ --static'" >> "$ALIASES"   # for 64-bit Windows
echo "alias win64gcc='x86_64-w64-mingw32-gcc --static'" >> "$ALIASES"   # for 64-bit Windows
echo "alias win32g++='i686-w64-mingw32-g++ --static'" >> "$ALIASES"     # for 32-bit Windows
echo "alias win32gcc='i686-w64-mingw32-gcc --static'" >> "$ALIASES"     # for 32-bit Windows

# Install Python modules using Pip
echo -e '\nInstalling Python Pip modules...\n'
sleep "$READING_TIME"
pip install numpy pandas matplotlib scipy ipython

# TODO: Set up ArnoldC
#echo -e '\nInstalling ArnoldC...\n'
#echo "alias arnoldc='bash $HOME/.local/bin/ArnoldC/run_arnoldc.sh'" >> "$ALIASES"

# TODO: OCaml install and setup

# TODO: Io install and setup

# TODO: Look into how to create a chroot jail (or how to use debootstrap, which surpisingly exists in Fedora's repos)

# Install and configure Vim
bash vim_config.sh "$pkg_mgr"

# Configure MPI to work with clang
echo -e '\nConfiguring MPI to work with Clang...\n'
echo "alias mpiclang='OMPI_CC=clang mpicc'" >> "$ALIASES"
echo "alias mpiclang++='OMPI_CC=clang++ mpic++'" >> "$ALIASES"

# TODO: Install Vivi (for screen sharing at school)

# TODO: Install VMware Horizon Linux client

# echo -e '\nNOTE: Check this script for notes on how to install the Waveforms SDK\n\n'
# Download and install the Adept runtime environment, then Waveforms
# https://mautic.digilentinc.com/adept-runtime-download     <- Adept runtime environment
# https://digilent.com/shop/software/digilent-waveforms/download    <- Waveforms SDK
# Tutorials:
#   - https://digilent.com/reference/software/waveforms/waveforms-3/getting-started-guide
#   - https://digilent.com/reference/test-and-measurement/guides/waveforms-using-waveforms-sdk
#firefox https://mautic.digilentinc.com/adept-runtime-download
#firefox https://digilent.com/shop/software/digilent-waveforms/download

# TODO: Download and install MATLAB
#firefox https://www.mathworks.com/downloads/
#echo "alias update-matlab='sudo /usr/local/MATLAB/R2021a/bin/glnxa64/update_installer'" >> .bash_aliases

# Add alias for thefuck
echo 'eval $(thefuck --alias)' >> "$HOME"/.bashrc

# Configure zsh
zsh zsh_config.sh

# Install Flatpak apps
bash flatpak_installs.sh

# TODO: Install Arduino with Teensyduino

# TODO: Map /media to /run/media
