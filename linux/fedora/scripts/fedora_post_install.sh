#!/bin/bash

if [ "$(id -u)" != 0 ]; then
     echo "You're not root! Run script with sudo" && exit 1
fi

./components/fedora_install_software.sh
./components/fedora_install_nerdfonts.sh
./components/fedora_configure.sh
