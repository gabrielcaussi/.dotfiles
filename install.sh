#!/usr/bin/env bash

# Project     : Fedora Workstation
# Description : Fedora Workstation for Software Engineer
# Developer   : Gabriel Caussi
# Github      : https://github.com/gabrielcaussi
# Linkedin    : https://www.linkedin.com/in/gabrielcaussi

# -------------------- VARIABLES -------------------- #
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

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"

# -------------------- FUNCTIONS -------------------- #
verify_os() {
	if [ -x "$(command -v dnf)" ] && grep -q ^NAME=Fedora /etc/os-release; then
  	echo "Installing softwares and settings:"
	else
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

  dnf install ${URL_GOOGLE_CHROME}
}

alacritty_setup() {
}

bash_setup() {
}

neovim_setup() {
}

git_setup() {
	ln -sf ~/.dotfiles/.gitconfig ~/
}

tmux_setup() {
	ln -sf ~/.dotfiles/.tmux.conf ~/
}

fonts_setup() {
	ln -sf ~/.dotfiles/.fonts ~/
}

gnome_setup() {
}

configure_softwares() {
	alacritty_setup

	bash_setup

	neovim_setup

	git_setup

	tmux_setup

	fonts_setup

	gnome_setup
}

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
