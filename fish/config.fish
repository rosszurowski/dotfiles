set NAME "Ross Zurowski"
set EMAIL "ross@rosszurowski.com"

set -x TERM "xterm-256color"
set -x LANG "en_US.UTF-8"
set -x LANGUAGE "en_US.UTF-8"
set -x LC_ALL "en_US.UTF-8"
set -x GPG_TTY (tty)

# if this breaks, run `brew --prefix` and use that value
set -x HOMEBREW_PREFIX "/opt/homebrew"
set -x HOMEBREW_BIN "$HOMEBREW_PREFIX/bin"
set -x PATH "$HOMEBREW_BIN" $PATH

# configure source code paths
set -x SRC "$HOME/Developer"
set -x DOTFILES "$SRC/dotfiles"
set -x PATH $PATH "$DOTFILES/bin"

# Configure paths for Go
set -x GOPATH "$SRC/go"
set -x PATH $PATH "$GOPATH/bin" "$GOROOT/bin"

# Load mise to manage runtime versions
$HOME/.local/bin/mise activate fish | source

# Load 1password CLI plugins
source /Users/rosszurowski/.config/op/plugins.sh

# Configure paths for Bun
set -Ux BUN_INSTALL "/Users/rosszurowski/.bun"
set -px --path PATH "/Users/rosszurowski/.bun/bin"

# Configure paths for pnpm
set -gx PNPM_HOME "/Users/rosszurowski/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH

# Hide Homebrew hints
set -x HOMEBREW_NO_ENV_HINTS 1

# Configure paths for Postgres.app
set -x PATH $PATH "/Applications/Postgres.app/Contents/Versions/latest/bin"

# Interactive mode settings
# Specifically, anything you might not need in scripting should be put here.
if status --is-interactive
  # Greeting on new terminal
  set fish_greeting

  # Filesysstem aliases
  alias reload 'exec fish -l'
  alias .. 'cd ..'
  alias ... 'cd ../..'

  # Web development aliases
  alias headers "curl -I -s -X GET"
  alias flush-dns "sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
  alias public-ip "dig +short myip.opendns.com @resolver1.opendns.com"
  alias internal-ip "ipconfig getifaddr en0 || ipconfig getifaddr en1"

  # Tailscale development aliases
  alias tailscale "/Applications/Tailscale.app/Contents/MacOS/Tailscale"
  alias dev-tailscaled "go run tailscale.com/cmd/tailscaled --tun=userspace-networking --socket=/tmp/ts/ts.sock --statedir=/tmp/ts"
  alias dev-tailscale "go run tailscale.com/cmd/tailscale --socket=/tmp/ts/ts.sock"
  alias dev-tailscaled-alt "go run tailscale.com/cmd/tailscaled --tun=userspace-networking --socket=/tmp/ts2/ts.sock --statedir=/tmp/ts2/"
  alias dev-tailscale-alt "go run tailscale.com/cmd/tailscale --socket=/tmp/ts2/ts.sock"
  alias dev-reset-tailnet-lock "trash /tmp/ts && trash ~/Library/Group\ Containers/W5364U7YZB.group.io.tailscale.ipn.macos/tka-profiles && trash ~/Library/Group\ Containers/W5364U7YZB.group.io.tailscale.ipn.macos/sameuserproof-*"

  # Add tool aliases
  alias youtube-dl "yt-dlp"
  alias jq "gojq"

  # macOS aliases
  alias update "sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup"
  alias caffeine "caffeinate -i"
  alias show "defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder"
  alias hide "defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder"

  # Add abbreviations for common typos
  abbr -a -g gti git
  abbr -a -g giit git
  abbr -a -g g git
  abbr -a -g gt git
  abbr -a -g gitst git st
  abbr -a -g sl ls

  # Add abbreviations for command line tools
  abbr -a -g loc tokei
  abbr -a -g sloc tokei

  # Configure paths for Tailscale development
  set -x PATH "./tool" $PATH
end
