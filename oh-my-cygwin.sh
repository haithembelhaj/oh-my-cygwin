#!/bin/bash
set -e

# install apt-cyg
APT_CYG="$(mktemp /tmp/apt-cyg.XXXXXXXX)"
wget --no-check-certificate "https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg" -O "${APT_CYG}"
chmod +x "${APT_CYG}"
install --backup "${APT_CYG}" /bin/apt-cyg
APT_CYG=/bin/apt-cyg

# install some stuff like vim and git
"${APT_CYG}" install zsh mintty vim curl git openssh git-completion git-gui gitk

# install OH MY ZSH
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Create initial /etc/zshenv
[[ ! -e /etc/zshenv ]] && echo export PATH=/usr/bin:\$PATH > /etc/zshenv

install --backup ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

#setting up vim
VIMRC_EXAMPLE=`find /usr/share/vim -type f -name vimrc_example.vim | head -n 1`
if [ ! -f ~/.vimrc ] && [ -n "${VIMRC_EXAMPLE}" ]
then
  install "${VIMRC_EXAMPLE}" ~/.vimrc
fi

# setting zsh as the default shell
setx SHELL /bin/zsh

# et voila just start it
/usr/bin/env zsh
