#!/bin/bash

GREEN=$(tput setaf 2)
BOLD=$(tput bold)
RESET=$(tput sgr0)

read -rp "What is this computer's name? [$HOSTNAME] " hostname
if [[ -n "$hostname" ]]; then
    hostnamectl set-hostname "$hostname"
fi

USER_HOME=$(eval echo "~$SUDO_USER")

echo "${BOLD}Setting up Pulse Audio...${RESET}"
PULSE_DIR="/etc/pulse"
sed -i "s/; default-sample-format = s16le/default-sample-format = s24le/g" "$PULSE_DIR/daemon.conf"
sed -i "s/; resample-method = speex-float-1/resample-method = speex-float-7/g" "$PULSE_DIR/daemon.conf"

echo "${BOLD}Setting up locale...${RESET}"
localectl set-locale LANG=en_IE.UTF-8
localectl set-locale LC_NUMERIC=en_IE.UTF-8
localectl set-locale LC_TIME=en_IE.UTF-8
localectl set-locale LC_MONETARY=en_IE.UTF-8
localectl set-locale LC_PAPER=en_IE.UTF-8
localectl set-locale LC_MEASUREMENT=en_IE.UTF-8
