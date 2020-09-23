#!/bin/bash

script_home="$PWD"

# install net-tools
sudo apt install -y net-tools

# get ms fonts
sudo apt-get install -y ttf-mscorefonts-installer

# copy font awesome
sudo cp fontawesome-webfont.ttf /usr/share/fonts/truetype/
sudo chmod 755 /usr/share/fonts/truetype/fontawesome-webfont.ttf

# install oh my zsh
cd || exit

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s "$(which zsh)"
sudo apt-get install fonts-powerline # Allows for theme to work for agnoster
cp ./.zshrc ~/.zshrc
cd "$script_home" || exit

# Make vim pretty
sudo apt-get upgrade vim
cp ./.vimrc ~/.vimrc