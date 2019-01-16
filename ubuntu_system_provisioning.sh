#!/bin/bash 
################################################################## 
# Script Name : ubuntu_system_provisioning.sh
# Description : Install software/packages after clean system bootstrap
# Author : Andrey Ruban
# Email :
##################################################################

UBUNTU=0
CENTOS=0

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
done

if [[ $UBUNTU == "1" ]]; then
    echo "Install packages "
    sudo apt install \
        wget \
        net-tools \
        pydf \
        python-pip \
        jq \ 
        python3.7 \
        python3-pip
fi

if [[ $CENTOS == "1" ]]; then
    echo "Install packages needed for making guake"
    sudo apt install \
        gettext \
        gsettings-desktop-schemas \
        make \
        pandoc
fi


