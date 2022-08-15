#!/bin/bash

READING_TIME=2
BASH_ALIASES="$HOME"/.bash_aliases
ZSH_ALIASES="$HOME"/.zsh_aliases
ALIASES="$ZSH_ALIASES"
ln -s "$ZSH_ALIASES" "$BASH_ALIASES"
distro="$1"
DEBIAN="debian bullseye"
FEDORA="fedora"
ROCKY="rocky"

if [ "$distro" = "$DEBIAN" ]
    then
    pkg_mgr=apt
    alt_pkg_mgr=dpkg
elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    pkg_mgr=dnf
    alt_pkg_mgr=rpm
elif [ "$distro" = "" ]
    then
    echo 'You must enter a distribution name for this script to work'
    exit -1
else
    echo 'That distribution is currently unsupported'
fi

sudo "$pkg_mgr" -y update
sudo "$pkg_mgr" -y upgrade

function install_pkg {
    sudo "$pkg_mgr" -y install "$*"
}

function rm_pkg {
    sudo "$pkg_mgr" -y remove "$*"
}

# Remove unwanted packages
echo -e '\nRemoving unwanted packages...\n'
sleep "$READING_TIME"
rm_pkg akregator kmail kmousetool kmouth kwrite libreoffice-core
if [ "$distro" = "$DEBIAN" ]
    then
    rm_pkg dragonplayer knotes konqueror kontrast termit
    sudo rm `sudo find / -name '*contactthemeeditor*'`	# Remove the Contact Theme Editor desktop icon
elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    rm_pkg akonadi-import-wizard dragon kgpg kmines kolourpaint konversation krdc krfb
    if [ "$distro" = "$FEDORA" ]
        then
        rm_pkg elisa-player
    elif [ "$distro" = "$ROCKY" ]
        then
        rm_pkg kcolorchooser
    fi
fi

# Reassign Okular shortcut for full screen mode from Ctrl+Shift+F to F11
sed -i 's;</gui>;  <Action shortcut="F11" name="fullscreen"/>\n </ActionProperties>\n</gui>;' ~/.local/share/kxmlgui5/okular/shell.rc

# Make edits to the sudoers file
bash visudo_edits.sh "$pkg_mgr" "$alt_pkg_mgr"
echo "alias su='sudo su'" >> "$HOME"/.zsh_aliases

# Update GRUB menu timeout
echo -e '\nUpdating GRUB menu timeout...\n'
sleep "$READING_TIME"
if [ "$distro" = "$FEDORA" ]
    then
    echo "alias update-grub='sudo grub2-mkconfig -o /boot/grub2/grub.cfg'" >> "$ALIASES"
fi
sudo sed -i 's;GRUB_TIMEOUT=5;GRUB_TIMEOUT=-1;' /etc/default/grub
source "$BASH_ALIASES"
update-grub

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

if [ "$distro" = "$FEDORA" ]
    then
    rpm -Uvh http://download1.rpmfusion.org/free/fedora/rmpfusion-free-release-stable.noarch.rpm
elif [ "$distro" = "$ROCKY" ]
    then
    install_pkg rpmfusion-free-release
    install_pkg fuse-exfat exfatprogs #exfat-utils
    install_pkg epel-release
fi

install_pkg clang clojure cmatrix dmg2img doxygen gimp gimp-heif-plugin gnote gprolog gprolog-docs htop
install_pkg julia julia-doc kate kmahjongg knights kpat ksudoku make nasm neofetch
install_pkg plasma-browser-integration python3-pip simplescreenrecorder racket racket-doc ruby ruby-doc
install_pkg screen sl vim-fugitive texstudio thefuck thunderbird tree vim vinagre vlc zsh
#install_pkg ddd debootstrap
#TODO: Will need to fix virt-manager later (possibly look into qt-virt-manager)
#TODO: Might need to install something else to get OpenMP to work with Clang
if [ "$distro" = "$DEBIAN" ]
    then
    install_pkg debootstrap default-jdk dos2unix ffmpeg firmware-misc-nonfree g++ libheif-examples
    install_pkg mingw-w64 net-tools nixnote2 python2
    install_pkg openmpi-bin openmpi-common libopenmpi3 libopenmpi-dev   # OpenMPI
    install_pkg texlive texlive-latex-extra texlive-latex-extra-doc     # LaTeX
    bash install_VMM.sh
    #bash install_RStudio.sh
elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    install_pkg gcc-c++ virt-manager
    if [ "$distro" = "$FEDORA" ]
        then
        install_pkg ffmpeg-free java-latest-openjdk libheif mingw{32,64}-gcc-c++ openmpi quentier
        install_pkg python2.7 #rstudio-desktop
        # NOTE: Quentier might be a better option for Debian as well
    elif [ "$distro" = "$ROCKY" ]
        then
        install_pkg python3
    fi
fi

# Start NixNote sync with Evernote on Debian (it will take awhile
if [ "$distro" = "$DEBIAN" ]
    then
    nixnote2 &
# TODO: Fedora: Don't know if Quentier will need the same yet
fi

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
# Setup access to the Raspberry Pi cluster
#bash cluster_access_setup/node_ssh_aliases_setup.sh
#bash cluster_access_setup/clusterssh_setup.sh

# Install JFLAP
echo -e '\nInstalling JFLAP...\n'
sleep "$READING_TIME"
bash install_JFLAP.sh

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

# Set up ArnoldC
echo -e '\nInstalling ArnoldC...\n'
echo "alias arnoldc='bash $HOME/.local/bin/ArnoldC/run_arnoldc.sh'" >> "$ALIASES"

# TODO: Still need to actually do this
# TODO: Move this out of college_stuff and into $HOME/.local/bin?
# OCaml install and setup
# NOTE: Ensure Torchwood is mounted before running this line
bash "$HOME"/Documents/college_stuff/7.\ Spring\ 2020/CSC\ 3710\ \(Foundations\ of\ Computer\ Science\)/OCaml\ Program/OCaml\ Setup/debian_ocaml_install.sh

# TODO: Still need to actually do this
# Io install and setup
bash update_Io.sh

# TODO: Look into how to create a chroot jail (or how to use debootstrap, which surpisingly exists in Fedora's repos)
# Alias for restarting chroot jail
#echo "alias chroot-startup='zsh ~/Documents/linux_files/chroot_jail/chroot_startup.sh'" >> "$ALIASES"

# Configure Vim
echo -e '\nConfiguring Vim...\n'
sleep "$READING_TIME"
bash vim_config.sh "$pkg_mgr"
# NOTE: There's probably an extra config step to get Julia to work properly in Vim

# Configure MPI to work with clang
echo -e '\nConfiguring MPI to work with Clang...\n'
sleep "$READING_TIME"
echo "alias mpiclang='OMPI_CC=clang mpicc'" >> "$ALIASES"
echo "alias mpiclang++='OMPI_CC=clang++ mpic++'" >> "$ALIASES"

# TODO: Install Vivi (for screen sharing at school)
if [ "$distro" = "$DEBIAN" ]
    then
    pkg_ext=deb
elif [ "$distro" = "$FEDORA" -o "$distro" = "$ROCKY" ]
    then
    pkg_ext="$alt_pkg_mgr"
fi
bash install_vivi.sh "$distro" "$pkg_ext"

# Install VMware Horizon Linux client
bash install_vmware_horizon.sh

# echo -e '\nNOTE: Check this script for notes on how to install the Waveforms SDK\n\n'
# Download and install the Adept runtime environment, then Waveforms
# https://mautic.digilentinc.com/adept-runtime-download     <- Adept runtime environment
# https://digilent.com/shop/software/digilent-waveforms/download    <- Waveforms SDK
# Tutorials:
#   - https://digilent.com/reference/software/waveforms/waveforms-3/getting-started-guide
#   - https://digilent.com/reference/test-and-measurement/guides/waveforms-using-waveforms-sdk
#firefox https://mautic.digilentinc.com/adept-runtime-download
#firefox https://digilent.com/shop/software/digilent-waveforms/download

# TODO: Download and install MATLAB (currently getting a "file too short" error for libicudata.so.69)
#firefox https://www.mathworks.com/downloads/
#echo "alias update-matlab='sudo /usr/local/MATLAB/R2021a/bin/glnxa64/update_installer'" >> .bash_aliases

# Add alias for thefuck
echo 'eval $(thefuck --alias)' >> "$HOME"/.bashrc

# Configure zsh
zsh zsh_config.sh

# Install Flatpak apps
echo -e '\nAdding Flathub repo and installing Flatpak apps...\n'
sleep "$READING_TIME"
bash flatpak_installs.sh

# Install Arduino with Teensyduino
echo -e '\nInstalling Arduino and Teensyduino...\n'
sleep "$READING_TIME"
bash install_teensyduino.sh

# TODO: Map /media to /run/media

# Setup WINE
#wine_install_and_setup.sh

if [ "$distro" = "$DEBIAN" ]
    then
    # TODO: Add disabling of touchscreen in /usr/share/X11/xorg.conf.d/40-libinput.conf
    firefox https://askubuntu.com/questions/198572/how-do-i-disable-the-touchscreen-drivers
fi

if [ "$distro" = "$ROCKY" ]
    then
    echo "alias clear=\"printf '\33c\e[3J'\"" >> "$ALIASES"
fi

sudo dnf -y autoremove
