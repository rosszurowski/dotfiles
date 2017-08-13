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

# Install and use latest bash
echo "> Changing shell to latest bash version..."
brew install bash
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells > /dev/null
chsh -s /usr/local/bin/bash

# Install useful binaries
binaries=(
  awscli
  bash-completion
  http_load
  hub
  go
  mas
  postgresql
  rename
  trash
  ssh-copy-id
  visionmedia-watch
  wget
  yarn
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
# Some npm defaults
npm config set init-license "MIT"
npm config set init-version "0.0.1"

# Install useful node modules
modules=(
  ava
  hpm-cli
  khaos
  psi
  serve
  standard
  svgo
  webpack
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
  drop-to-gif
  firefox
  google-chrome
  hyper
  imageoptim
  notational-velocity
  robofont
  sketch
  slack
  transmission
  transmit
  unrarx
  vlc
)

masapps=(
  504544917 # Clear
  975937182 # Fantastical
  775737590 # iA Writer
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
cd $CLONE_PATH && make install

# Remove outdated versions from the cellar
echo "> Cleaning up..."
brew cleanup
brew cask cleanup
