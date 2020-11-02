# --------------- Credits ---------------
# File:   .zshrc
# Author: Gabriel Caussi
# Source: https://github.com/gabrielcaussi/dotfiles/

# --------------- Zsh settings ---------------

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="kafeitu"

# Plugins 
plugins=(git)

# Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Alias
alias q='exit'
alias vim='nvim'
alias setvim='nvim ~/.config/nvim/init.vim'
alias setzsh='nvim ~/.zshrc'
alias settmux='nvim ~/.tmux.conf'
alias setkitty='nvim ~/.config/kitty/kitty.conf'
alias setktheme='nvim ~/.config/kitty/theme.conf'
alias setgit='~/.gitconfig'
alias nametmux='tmux new -s'
alias retmux='tmux attach -t'

# Hide % on start
unsetopt PROMPT_SP

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

