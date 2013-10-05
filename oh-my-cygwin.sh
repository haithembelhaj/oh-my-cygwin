#!/bin/bash

# install apt-cyg
wget --no-check-certificate https://github.com/john-peterson/apt-cyg/raw/path/apt-cyg
chmod +x apt-cyg
mv apt-cyg /bin/apt-cyg

# install some stuff like vim and git
apt-cyg install zsh mintty vim curl git openssh git-completion git-gui gitk

#setting up vim
cp /usr/share/vim/vim73/vimrc_example.vim ~/.vimrc

# Create initial /etc/zshenv
[[ ! -e /etc/zshenv ]] && echo export PATH=/usr/bin:\$PATH > /etc/zshenv

# install OH MY ZSH
/usr/bin/env git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
then
  cp ~/.zshrc ~/.zshrc.orig;
  rm ~/.zshrc;
fi
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# setting up zsh as default
sed -i "s/$USER\:\/bin\/bash/$USER\:\/bin\/zsh/g" /etc/passwd

# et voila just start it
/usr/bin/env zsh



