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
          UBUNTU=1
          ;;
        centos)
          CENTOS=1
          ;;
        *)
          echo "Please, select ubuntu or centos OS"
    esac
    shift
done

if [[ $UBUNTU == "1" ]]; then
    echo "Install packages "
    sudo apt install \
        wget \
        net-tools \
        pydf \
        python-pip \
        jq \ 
        python3.\7 

fi

if [[ $CENTOS == "1" ]]; then
    echo "Install packages needed for making guake"
    sudo apt install \
        gettext \
        gsettings-desktop-schemas \
        make \
        pandoc
fi


