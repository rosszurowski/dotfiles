#!/usr/bin/env bash

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "> Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install and use latest bash
echo "> Changing shell to latest bash version..."
brew install bash
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells > /dev/null
chsh -s /usr/local/bin/bash

# Install useful binaries
binaries=(
  bash-completion
  http_load
  rename
  ssh-copy-id
  wget
)

echo "> Installing useful binaries..."
brew install ${binaries[@]}

# Install git
echo "> Installing git..."
brew install git
# Some git defaults
git config --global color.ui true
git config --global push.default simple

# Install node and iojs
echo "> Installing node and iojs..."
brew install node
npm install -g n
n latest
n io latest
# Some npm defaults
npm config set init-license "MIT"
npm config set init-version "0.0.1"

# Install useful node modules
modules=(
  airpaste
  browserify
  psi
  mocha
  serve
  standard
)

echo "> Installing useful node modules..."
npm install -g ${modules[@]}

# Install go
brew install go

# Install brew cask
echo "> Installing brew cask..."
brew install caskroom/cask/brew-cask

# Install applications
apps=(
  dropbox
  firefox
  google-chrome
  imageoptim
  sketch
  sublime-text3
)

echo "> Installing applications..."
brew cask install --appdir="/Applications" ${apps[@]}

# Clone this repo into ./dotfiles
echo "> Cloning into dotfiles repo..."
git clone https://github.com/rosszurowski/dotfiles ./dotfiles

# Linking dotfiles
echo "> Linking dotfiles to $HOME..."
cd ./dotfiles && make install

# Remove outdated versions from the cellar
echo "> Cleaning up..."
brew cleanup
