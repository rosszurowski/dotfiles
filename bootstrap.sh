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
  hub
  go
  git
  mas
  postgresql
  rename
  terminal-notifier
  trash
  ssh-copy-id
  wget
  yarn
)

echo "> Installing useful binaries..."
brew install ${binaries[@]}

# Install node and iojs
echo "> Installing node and iojs..."
brew install node
npm install -g n
n latest
# Some npm defaults
npm config set init-license "MIT"
npm config set init-version "0.0.1"

# Install useful node modules
modules=(
  psi
  serve
  svgo
  webpack
  xo
)

echo "> Installing useful node modules..."
npm install -g ${modules[@]}

# Install brew cask
echo "> Installing brew cask..."
brew install caskroom/cask/brew-cask

# Install applications
apps=(
  1password
  atom
  dropbox
  firefox
  google-chrome
  iterm2-beta
  imageoptim
  kap
  notational-velocity
  robofont
  slack
  spotify
  sketch
  transmission
  transmit
  unrarx
  vlc
)

masapps=(
  904280696 # Things
  975937182 # Fantastical
  775737590 # iA Writer
  692867256 # Simplenote
  409183694 # Keynote
  409203825 # Numbers
  409201541 # Pages
  880001334 # Reeder
)

echo "> Installing applications..."
brew cask install --appdir="/Applications" ${apps[@]}
mas install ${masapps[@]}

# Install quicklook plugins
qlplugins=(
  qlcolorcode
  qlmarkdown
  qlstephen
)

echo "> Installing QuickLook plugins..."
brew cask install ${qlplugins[@]}

qlmanage -r
qlmanage -r cache

echo "> Installing services..."
brew tap homebrew/services

echo "> Installing Input typeface..."
TMPDIR=`mktemp -d`
curl "http://input.fontbureau.com/build?customize&fontSelection=whole&a=0&g=0&i=serif&l=serif&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do" > $TMPDIR/input.zip
unzip $TMPDIR/input.zip -d $TMPDIR
mv $TMPDIR/**/*.ttf ~/Library/Fonts/

# Clone this repo into ./dotfiles
read -p "Choose where to clone the dotfiles repo: " -i "$HOME/Sites/dotfiles" -e CLONE_PATH
echo "> Cloning into dotfiles repo..."
mkdir -p $CLONE_PATH
git clone https://github.com/rosszurowski/dotfiles $CLONE_PATH

echo "> Install Atom packages..."
apm install --packages-file $CLONE_PATH/atom/packages.txt

# Linking dotfiles
echo "> Linking dotfiles to $HOME..."
cd $CLONE_PATH && script/setup

# Remove outdated versions from the cellar
echo "> Cleaning up..."
brew cleanup
brew cask cleanup
