#!/bin/bash
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

##################################################################################################################

	echo
	tput setaf 2
	echo "##################################################"
	echo "### Modifying pacman.conf with custom settings ###"
	echo "##################################################"
	tput sgr0
	echo

	FIND="#Color"
	REPLACE="Color"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

	FIND="#CheckSpace"
	REPLACE="CheckSpace"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

	FIND="#VerbosePkgLists"
	#REPLACE="VerbosePkgLists"
	# Add ILoveCandy
	REPLACE="VerbosePkgLists\\nILoveCandy"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

	FIND="ParallelDownloads = 5"
	REPLACE="ParallelDownloads = 8"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

	echo
	tput setaf 2
	echo "############"
	echo "### DONE ###"
	echo "############"
	tput sgr0

fi
