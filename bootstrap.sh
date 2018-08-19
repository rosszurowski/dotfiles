#!/usr/bin/env bash

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "> Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if test ! $(which brew); then
  echo ""
  echo "> Homebrew install failed! Try again manually by running"
  echo "> ruby -e \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
  echo ""
fi

# Update homebrew recipes
brew update

# Install and use latest zsh
echo "> Changing shell to latest zsh version..."
brew install zsh
echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells > /dev/null
chsh -s /usr/local/bin/zsh

# Install useful binaries
binaries=(
  awscli
  fd
  fzf
  go
  git
  hub
  mas
  neovim
  postgresql
  rename
  terminal-notifier
  trash
  shellcheck
  ssh-copy-id
  wget
)

echo "> Installing useful binaries..."
brew install "${binaries[@]}"

# Install node and iojs
echo "> Installing node..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install node
# Some npm defaults
npm config set init-license "MIT"
npm config set init-version "0.0.1"

# Install useful node modules
modules=(
  diff-so-fancy
  psi
  serve
  svgo
  webpack
  yarn
  vmd
)

echo "> Installing useful node modules..."
npm install -g "${modules[@]}"

# Install brew cask
echo "> Installing brew cask..."
brew tap caskroom/cask

# Install applications
masapps=(
  904280696 # Things
  775737590 # iA Writer
  692867256 # Simplenote
  409183694 # Keynote
  409203825 # Numbers
  409201541 # Pages
  880001334 # Reeder
)

echo "> Install App Store applications..."
mas signin "ross@rosszurowski.com"
mas install "${masapps[@]}"

apps=(
  1password
  atom
  beaker-browser
  firefox
  firefoxnightly
  google-chrome
  iterm2
  imageoptim
  kap
  oryoki
  robofont
  slack
  spotify
  sketch
  transmission
  transmit
  unrarx
  vlc
)

echo "> Installing applications..."
brew cask install --appdir="/Applications" "${apps[@]}"

# Install quicklook plugins
qlplugins=(
  qlcolorcode
  qlmarkdown
  qlstephen
)

echo "> Installing QuickLook plugins..."
brew cask install "${qlplugins[@]}"

qlmanage -r
qlmanage -r cache

echo "> Installing services..."
brew tap homebrew/services

echo "> Installing font library..."
script/fonts-download

# Clone this repo into ./dotfiles
read -p "Choose where to clone the dotfiles repo: " -i "$HOME/Sites/dotfiles" -e CLONE_PATH
echo "> Cloning into dotfiles repo..."
mkdir -p $CLONE_PATH
git clone https://github.com/rosszurowski/dotfiles $CLONE_PATH

# Linking dotfiles
echo "> Linking dotfiles to $HOME..."
cd $CLONE_PATH && script/zsh && script/setup

echo "> Install Atom packages..."
apm install --packages-file atom/packages.txt

# Remove outdated versions from the cellar
echo "> Cleaning up..."
brew cleanup
brew cask cleanup
