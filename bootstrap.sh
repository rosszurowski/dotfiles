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
sudo echo '/usr/local/bin/bash' >> /etc/shells
chsh -s /usr/local/bin/bash

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

# Install useful node modules
modules=(
  browserify
  psi
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
applications=(
  chocolat
  dropbox
  firefox
  google-chrome
  sketch
)

echo "> Installing applications..."
brew cask install --appdir="/Applications" ${apps[@]}

# Clone this repo into ./dotfiles
echo "> Cloning dotfiles repo..."
git clone https://github.com/rosszurowski/dotfiles ./dotfiles

# Remove outdated versions from the cellar
echo "> Cleaning up..."
brew cleanup

function doIt() {
  for file in .{profile,path,exports,aliases,functions,gitignore,gitconfig}; do
    [ -r "$file" ] && [ -f "$file" ] && ln -sf "$(pwd)/$file" "$HOME/$file"
  done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
if [ $? -eq 0 ]; then
    echo "Done. Restart your terminal for the changes to take effect."
else
    echo "Some files had errors while linking. Please delete any existing files and try again."
fi
unset doIt;