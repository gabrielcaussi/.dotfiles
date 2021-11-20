# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

## Agnoster Theme
export THEME=$HOME/agnoster.bash
if [[ -f $THEME ]]; then
    export DEFAULT_USER=`whoami`
    source $THEME
fi

# Use Neovim as default editor
export EDITOR=nvim

# My Aliases
alias q='exit'
alias ..='cd ..'
alias ll='ls -al'
alias vim='nvim'
alias ipp='curl ipinfo.io/ip'
alias nametmux='tmux new -s'
alias retmux='tmux attach-session -t'
alias killtmux='tmux kill-session -t'
alias tmuxconf='nvim ~/.tmux.conf'
alias vimconf='nvim ~/.config/nvim/init.vim'
alias zshconf='nvim ~/.zshrc'
alias gitconf='nvim ~/.gitconfig'
alias kittyconf='nvim ~/.config/kitty/kitty.conf'
alias work='cd ~/Projects'
