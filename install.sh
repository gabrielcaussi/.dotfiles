#!/usr/bin/env bash

# Project     : Fedora KDE Plasma
# Description : Workstation running Fedora Linux KDE Plasma
# Developer   : Gabriel Caussi
# Github      : https://github.com/gabrielcaussi
# Linkedin    : https://www.linkedin.com/in/gabrielcaussi

# -------------------- VARIABLES -------------------- #
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"

PROGRAMS_LIST=(
	bash-completion
	curl
	ffmpeg
	g++
	gcc
	git
	htop
	hugo
	neofetch
	neovim
	obs-studio
	tmux
	util-linux
	wget
	zsh
)

# -------------------- FUNCTIONS -------------------- #
verify_os() {
  if [ ! "$(cat /etc/os-release | grep NAME=Fedora)" == "NAME=Fedora" ]; then
    echo "Sorry, this script is intended only for Fedora Linux!"
    exit 1
  fi
}

ask_for_sudo() {
	sudo -v &>/dev/null
	# Update existing `sudo` time stamp until this script has finished
	# https://gist.github.com/cowboy/3118588
	while true; do
		sudo -n true
		sleep 60
		kill -0 "$$" || exit
	done &>/dev/null &
}

system_requerements() {
	# Update system
	dnf update -y

	# Install Non-Free repositories
	dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	# Update system again
	dnf update -y

	# Install wifi module for Thinkpad E431 (BCM43142)
	dnf install broadcom-wl -y
}

install_softwares() {
	dnf install ${PROGRAMS_LIST[@]}
}

configure_softwares() {
	# Git
	ln -sf ~/.dotfiles/.gitconfig ~/

	# Tmux
	ln -sf ~/.dotfiles/.tmux.conf ~/

	# Fonts
	ln -sf ~/.dotfiles/.fonts ~/

	# Plasma setup
	plasma-apply-lookandfeel -a org.kde.breezedark.desktop
	plasma-apply-wallpaperimage ~/.dotfiles/wallpaper.png

# -------------------- MAIN -------------------- #
main() {
	verify_os

	ask_for_sudo

	system_requerements

	install_softwares

	configure_softwares

	echo "Success! Please restart the terminal to see the changes!"
}

main
