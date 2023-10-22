#!/bin/bash

ARCH_PKGS="podman cockpit cockpit-podman"
FEDORA_PKGS="podman cockpit cockpit-podman zfs"

abnormal_exit() {
   echo "Error: $1"
   exit 1
}

# Clean up on exit
trap "pkill -P $$" EXIT

# Determine what distro we are working with
if [ -n /etc/os-release ]; then
   . /etc/os-release
   if [ -n $ID ]; then
      DISTRO=$(echo $ID | tr [:upper:] [:lower:]) 
   elif [ -n $ID_LIKE ]; then
      DISTRO=$(echo $ID_LIKE | tr [:upper:] [:lower])
   fi
fi

# Update the system and install packages
case $DISTRO in
   "arch")
      echo "Updating the system ..."
      pacman -Syu --no-confirm
      
      echo "Installing packages ..."
      pacman -S $ARCH_PKGS --no-confirm  
      ;;
   "fedora")
      echo "Updating the system ..."
      dnf -y update
      
      echo "Installing packages ..."
      dnf -y install $FEDORA_PKGS
      ;;
   *)
      abnormal_exit "Distro Not Found"   
      ;;
esac

# Get docker image






