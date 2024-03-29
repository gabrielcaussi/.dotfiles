#!/usr/bin/env bash

# Project     : Fedora Workstation
# Description : Fedora Workstation for Software Engineer
# Developer   : Gabriel Caussi
# Github      : https://github.com/gabrielcaussi
# Linkedin    : https://www.linkedin.com/in/gabrielcaussi

# -------------------- VARIABLES -------------------- #
PROGRAMS_LIST=(
	alacritty
	bash-completion
	curl
	ffmpeg
	git
  gnome-shell-extension-user-theme
	htop
	hugo
	neofetch
	obs-studio
	tmux
	util-linux
  vim
	wget
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

	rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	dnf check-update
	dnf install code
}

terminal_setup() {
	~/.dotfiles/gnome-terminal/nord.sh
}

bash_setup() {
  ln -sf ~/.dotfiles/bash/.bashrc ~/
  ln -sf ~/.dotfiles/bash/.bash_aliases ~/
  ln -sf ~/.dotfiles/bash/.bash_profile ~/
  ln -sf ~/.dotfiles/bash/.bash_agnoster ~/
  ln -sf ~/.dotfiles/bash/.exports ~/
}

vim_setup() {
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  ln -sf ~/.dotfiles/.vimrc ~/

  vim +PlugInstall +qall

  mkdir ~/.vim/undo
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
  ln -sf ~/.dotfiles/.themes ~/
  ln -sf ~/.dotfiles/.icons ~/

	gsettings set org.gnome.desktop.interface gtk-theme "Nordic-darker-v40"
	gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
  gsettings set org.gnome.desktop.interface cursor-theme 'Nordzy-cursors'
	gsettings set org.gnome.desktop.background picture-uri ~/.dotfiles/wallpapers/wallpaper.png
	gsettings set org.gnome.desktop.screensaver picture-uri ~/.dotfiles/wallpapers/wallpaper.png
	gsettings set org.gnome.desktop.interface show-battery-percentage true
	gsettings set org.gnome.desktop.interface clock-show-date true
	gsettings set org.gnome.desktop.interface text-scaling-factor 0.9
}

configure_softwares() {
	terminal_setup

	bash_setup

	vim_setup

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
