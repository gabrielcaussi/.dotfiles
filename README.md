# My Dotfiles

My dotfiles for web development with kitty, zsh, neovim, tmux and Live-server.

![Desktop](/screenshots/desktop.png)

## Install programs

Run the command:

```bash
$ sudo pacman -Syu curl git kitty zsh neovim tmux htop neofetch firefox chromium --noconfirm
```

## Install programming languages

Install NVM (Node Version Manager):

```bash
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
```

Restart the terminal and check if the NVM was installed correctly:

```bash
$ nvm -v
```

Install Node.js:

```bash
$ nvm ls-remote
```

Select the latest LTS version:

```bash
$ nvm install <version>
```

Test that everything was installed correctly:

```bash
$ node -v

$ npm -v
```

## Clone the repository

Clone the repository:

```bash
$ git clone https://github.com/gabrielcaussi/.dotfiles.git
```

Confirm that everything was installed correctly:

```bash
$ cd ~/.dotfiles

$ ls -al
```

# Install Dotfiles

## ZSH

Install Oh-My-Zsh:

```bash
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

After making the necessary Oh-My-Zsh settings, remove the original .zshrc file:

```bash
$ rm ~/.zshrc
```

Create the symbolic link:

```bash
$ ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

$ zsh
```

## Kitty

Create the symbolic links:

```zsh
$ mkdir ~/.config/kitty

$ ln -s ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf

$ ln -s ~/.dotfiles/kitty/theme.conf ~/.config/kitty/theme.conf
```

## NeoVim

Install Vim-Plug

```zsh
$ curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Create the symbolic link:

```zsh
$ ln -s ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim
```

Finally open NeoVim, press <kbd>Ctrl+D</kbd> and wait for the plugins to be installed.

## Git

Create the symbolic link:

```zsh
$ ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig
```

## Tmux

Create the symbolic link:

```zsh
$ ln -s ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

## Fonts

Install Fira Code:

```zsh
$ sudo pacman -S ttf-fira-code --noconfirm
```

Create the fonts folder:

```zsh
$ mkdir ~/.local/share/fonts
```

Copy the font to the folder:

```
$ cp ~/.dotfiles/.fonts/Hack\ Regular\ Nerd\ Font\ Complete\ Mono.ttf ~/.local/share/fonts
```

## Themes and Icons

Install themes and icons:

```zsh
$ mkdir ~/.themes && mkdir ~/.icons

$ cp ~/.dotfiles/.themes/WhiteSur-dark-alt ~/.themes

$ cp ~/.dotfiles/.icons/Papirus ~/.icons

$ cp ~/.dotfiles/.icons/Papirus-Dark ~/.icons
```

## Live-server

Install Live-server:

```zsh
$ npm install -g live-server
```

To use run the command:

```zsh
$ live-server project_folder/
```
