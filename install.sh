#!/bin/bash

## Project:     Ubuntu Workstation
## Description: Electronic Engineering Workstation Running Ubuntu
## Developer:   Gabriel Caussi
## Github:      https://github.com/gabrielcaussi
## Linkedin:    https://www.linkedin.com/in/gabrielcaussi

echo ""
echo ""
echo "  _   _ ____  _   _ _   _ _____ _   _       ___ _   _ ____ _____  _    _     _     _____ ____   "
echo " | | | |  _ \| | | |  \| | | | | | | |     |_ _| \ | / ___|_   _|/ \  | |   | |   | ____|  _ \  "
echo " | | | |  _ \| | | |  \| | | | | | | |      | ||  \| \___ \ | | / _ \ | |   | |   |  _| | |_) | "
echo " | |_| | |_) | |_| | |\  | | | | |_| |      | || |\  |___) || |/ ___ \| |___| |___| |___|  _ <  "
echo "  \___/|____/ \___/|_| \_| |_|  \___/      |___|_| \_|____/ |_/_/   \_\_____|_____|_____|_| \_\ "
echo ""
echo ""

## Update System
sudo apt update && sudo apt upgrade -y

## Install Softwares
sudo apt install broadcom-sta-dkms zsh curl git neofetch htop ufw gufw neovim tmux fonts-firacode build-essential hugo flameshot firefox arduino gimp inkscape kdenlive kicad freecad virtualbox telegram-desktop -y

## Softwares failed
echo ""
echo ""
echo "Falta instalar: Vivaldi, VS Code, Notion, Spotify, MPLabX, LTSpice, Octave"
echo ""
echo ""
