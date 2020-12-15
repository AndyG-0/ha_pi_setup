#!/bin/bash

script_home="$PWD"

# install net-tools
sudo apt install -y net-tools

sudo apt install -y zsh

sudo apt install -y zsh-syntax-highlighting

# get ms fonts
sudo apt-get install -y ttf-mscorefonts-installer

# copy font awesome
sudo cp fontawesome-webfont.ttf /usr/share/fonts/truetype/
sudo chmod 755 /usr/share/fonts/truetype/fontawesome-webfont.ttf

# install oh my zsh
cd || exit

git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlightinggit clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

echo Changing shell ... provide password:
chsh -s "$(which zsh)"
sudo apt-get install -y fonts-powerline # Allows for theme to work for agnoster

sed -i -r "s/andy([^0-9])+/$(whoami)/g" ~/.kube/config

cp ./.zshrc ~/.zshrc

# Make vim pretty
sudo apt-get upgrade -y vim
cp ./.vimrc ~/.vimrc

cd "$script_home" || exit
