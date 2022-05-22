#!/usr/bin/env bash

# Check for Homebrew,
# Install if we don't have it
if test ! "$(which brew)"; then
  echo "> Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if test ! "$(which brew)"; then
  echo ""
  echo "> Homebrew install failed! Try again manually by running"
  echo "> /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
  echo ""
fi

# Update homebrew recipes
brew update

HOMEBREW_PATH="$(brew --prefix)/bin"

# Install and use latest fish
echo "> Changing shell to latest fish version..."
brew install fish
echo "$HOMEBREW_PATH/fish" | sudo tee -a /etc/shells > /dev/null
chsh -s "$HOMEBREW_PATH/fish"

# Install useful binaries
binaries=(
  deno
  entr
  fzf
  gh
  git
  git-delta
  go
  goreleaser/tap/goreleaser
  hugo
  jq
  mas
  neovim
  rename
  terminal-notifier
  trash
  shellcheck
  ssh-copy-id
  upx
  wget
  xh
  yt-dlp/taps/yt-dlp
  zola
)

echo "> Installing useful binaries..."
brew install "${binaries[@]}"

# Install node via volta
echo "> Installing node..."
curl https://get.volta.sh | bash
volta install node
volta install yarn
# Some npm defaults
yarn config set init-license "MIT"
yarn config set init-version "0.0.1"

# Install useful node modules
modules=(
  serve
  svgo
)

echo "> Installing useful node modules..."
yarn global add "${modules[@]}"

# Install applications
masapps=(
  904280696  # Things
  775737590  # iA Writer
  409183694  # Keynote
  409203825  # Numbers
  409201541  # Pages
  824183456  # Affinity Photo
  824171161  # Affinity Designer
)

echo "> Install App Store applications..."
mas signin "ross@rosszurowski.com"
mas install "${masapps[@]}"

apps=(
  1password
  arq
  audio-hijack
  cleanshot
  daisydisk
  figma
  firefox
  iterm2
  imageoptim
  mimestream
  raycast
  signal
  slack
  spotify
  sketch
  transmission
  transmit
  visual-studio-code
  vlc
)

echo "> Installing applications..."
brew install --cask --appdir="/Applications" "${apps[@]}"

echo "> Installing font library..."
script/fonts-download

echo "> Setting up Raycast (key in 1Password)"
open ./raycast/settings.rayconfig

# Set up GPG keys
script/setup-gpg

# Clone this repo into ./dotfiles
read -r -p "Choose where to clone the dotfiles repo: " -i "$HOME/Developer/dotfiles" -e CLONE_PATH
echo "> Cloning into dotfiles repo..."
mkdir -p "$CLONE_PATH"
git clone https://github.com/rosszurowski/dotfiles "$CLONE_PATH"

# Linking dotfiles
echo "> Linking dotfiles to $HOME..."
cd "$CLONE_PATH" && script/zsh && script/setup

# Remove outdated versions from the cellar
echo "> Cleaning up..."
brew cleanup
