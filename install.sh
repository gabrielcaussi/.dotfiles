#!/bin/bash

## Project:     Voidlinux Workstation
## Description: DevOps Engineer Workstation Running Voidlinux
## Developer:   Gabriel Caussi
## Github:      https://github.com/gabrielcaussi
## Linkedin:    https://www.linkedin.com/in/gabrielcaussi

echo ""
echo ""
echo " ___ _   _ ____ _____  _    _     _     _____ ____   "
echo "|_ _| \ | / ___|_   _|/ \  | |   | |   | ____|  _ \  "
echo " | ||  \| \___ \ | | / _ \ | |   | |   |  _| | |_) | "
echo " | || |\  |___) || |/ ___ \| |___| |___| |___|  _ <  "
echo "|___|_| \_|____/ |_/_/   \_\_____|_____|_____|_| \_\ "
echo ""
echo ""

## Update System
sudo xbps-install -Syu

## Install Softwares
sudo xbps-install 

xorg
bspwm
polybar
rofi
lxappearance
qt5ct
pulseaudio
NetworkManager
feh
sxhkd
xinit
xrandr
playerctl
fonts-roboto-ttf
broadcom-wl-dkms
zsh
curl
git
neofetch
htop
ufw
neovim
tmux
kitty
virtualbox-ose
hugo
flameshot
firefox
nemo
vagrant

firacode
