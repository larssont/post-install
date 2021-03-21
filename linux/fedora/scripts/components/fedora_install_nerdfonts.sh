#!/bin/bash

GREEN=$(tput setaf 2)
BOLD=$(tput bold)
RESET=$(tput sgr0)

fonts=("AnonymousPro" "Cousine" "FantasqueSansMono" "Inconsolata" "Hack" "Hasklig" "FiraCode" "IBMPlexMono" "Iosevka" "CascadiaCode" "SourceCodePro")

cat <<EOL
${BOLD}Nerd Fonts patched fonts to install${RESET}
${BOLD}-----------------------------------${RESET}
Fonts: ${GREEN}${fonts[*]}${RESET}
EOL
read -rp "Press enter to install, or ctrl+c to quit"

FONTS_TMP_DIR=/tmp/nerdfonts

git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git $FONTS_TMP_DIR

for font in "${fonts[@]}"; do
    /tmp/nerdfonts/install.sh -S "$font"
done

rm -r $FONTS_TMP_DIR
