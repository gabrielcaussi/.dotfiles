# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)

# Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Terminal color
export TERM=xterm-256color

# Alias
alias q='exit'
alias vim='nvim'
alias setvim='nvim ~/.config/nvim/init.vim'
alias setzsh='nvim ~/.zshrc'
alias setgit='nvim ~/.gitconfig'
alias settmux='nvim ~/.tmux.conf'
alias nametmux='tmux new -s'
alias retmux='tmux attach -t'
alias getwmclass="xprop | awk '/WM_CLASS/{print $4}'"

