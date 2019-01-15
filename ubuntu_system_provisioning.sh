#!/bin/bash 
################################################################## 
# Script Name : ubuntu_system_provisioning.sh
# Description : Install software after clean system installation
# Author : Andrey Ruban
# Email :
##################################################################

ubuntu=0
centos=0

ARGC="$#"

while test $# -gt 0
do
    case "$1" in
        ubuntu)
          ubuntu=1
          ;;
        centos)
          centos=1
          ;;
    esac
    shift
done

if [[ "$ARGC" == "0" ]]; then
          RUN=1;
          MAKE=1;
          DEV=1;
          OPT=0;
fi


if [[ $RUN == "1" ]]; then
    echo "Install packages "
    sudo apt install \
        python-pip \
        # utility for prety json formatting in pipeline
        jq \
        python3.7 \
        python3-pip
fi

if [[ $MAKE == "1" ]]; then
    echo "Install packages needed for making guake"
    sudo apt install \
        gettext \
        gsettings-desktop-schemas \
        make \
        pandoc
fi

if [[ $DEV == "1" ]]; then
    echo "Install needed development packages"
    sudo apt install \
        aspell-fr \
        colortest \
        dconf-editor \
        glade \
        poedit \
        gnome-tweak-tool
fi

if [[ $OPT == "1" ]]; then
    echo "Install packages optional for execution"
    sudo apt install \
        numix-gtk-theme
fi
