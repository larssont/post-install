#!/bin/bash

#==============================================================================
# script settings and checks
#==============================================================================
set -euo pipefail
exec 2> >(tee "error_log_$(date -Iseconds).txt")

GREEN=$(tput setaf 2)
BOLD=$(tput bold)
RESET=$(tput sgr0)

if [[ $(rpm -E %fedora) -lt 33 ]]; then
    echo >&2 "You must install at least ${GREEN}Fedora 33${RESET} to use this script" && exit 1
fi

# >>>>>> start of user settings <<<<<<

#==============================================================================
# common packages to install/remove *arrays can be left empty, but don't delete
#==============================================================================

packages_to_remove=(
    gedit
    )

packages_to_install=(
    atool
    bat
    fd
    fish
    fzf
    gimp
    htop
    kitty
    neovim
    p7zip
    ripgrep
    ShellCheck
    xclip
    )

#==============================================================================
# Ask for user input
#==============================================================================
clear
read -rp "Are you going to use this machine for gaming? (y/n) " -n 1 gaming
echo
echo

if [[ $gaming =~ ^[Yy]$ ]]; then
    #==========================================================================
    # packages for web development option * deno added if selected
    #==========================================================================
    gaming_packages=(
	    discord
	    steam
	    )
    
    packages_to_install+=("${gaming_packages[@]}")

elif [[ ! $gaming =~ ^[Nn]$ ]]; then
    echo "Invalid selection" && exit 1
fi

# >>>>>> end of user settings <<<<<<

#==============================================================================
# display user settings
#==============================================================================
cat <<EOL
${BOLD}Packages to install${RESET}
${BOLD}-------------------${RESET}
DNF packages: ${GREEN}${packages_to_install[*]}${RESET}

${BOLD}Packages to remove${RESET}
${BOLD}------------------${RESET}
DNF packages: ${GREEN}${packages_to_remove[*]}${RESET}

EOL
read -rp "Press enter to install, or ctrl+c to quit"

#==============================================================================
# add default and conditional repositories
#==============================================================================
echo "${BOLD}Adding repositories...${RESET}"
dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm 
dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm

#==============================================================================
# install packages
#==============================================================================
echo "${BOLD}Removing unwanted programs...${RESET}"
dnf -y remove "${packages_to_remove[@]}"

echo "${BOLD}Updating Fedora...${RESET}"
dnf -y --refresh upgrade

echo "${BOLD}Installing packages...${RESET}"
dnf -y install "${packages_to_install[@]}"
dnf group upgrade --with-optional Multimedia

cat <<EOL
=============================================================================
Congratulations, everything is installed!
Now use the setup script...
=============================================================================
EOL
