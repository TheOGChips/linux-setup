#!/bin/bash
# A script to install R and RStudio

# Install R
sudo apt -y install r-base
# Necessary packages for CSC 3220 RStudio assignments
sudo apt -y install libxml2-dev
sudo apt -y install libcurl4-openssl-dev
sudo apt -y install libssl-dev

# Install RStudio (change version name of deb file as necessary)
echo
echo "Go download the RStudio deb archive from their website."
rstudio_downloaded=n

until [ $rstudio_downloaded = "y" ]
do
	read -p "Have you downloaded the Eclipse installer yet? (y/n) " rstudio_downloaded
	if [ $rstudio_downloaded != "n" -a $rstudio_downloaded != "y" ]
	then
		echo "That wasn't even an option, moron."
	fi
done

echo "RStudio has been downloaded."
package="rstudio.deb"
mv ~/Downloads/rstudio*.deb ~/"$package"
sudo apt -y install ./"$package"
rm ~/"$package"
