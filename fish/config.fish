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
set -x GOROOT "$HOMEBREW_PREFIX/opt/go/libexec"
set -x PATH $PATH "$GOPATH/bin" "$GOROOT/bin"

# Configure paths for Volta (npm/node/yarn)
set -x VOLTA_HOME "$HOME/.volta"
set -x PATH $PATH "$VOLTA_HOME/bin"

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
  alias dev-tailscaled "go run tailscale.com/cmd/tailscaled --tun=userspace-networking --socket=/tmp/ts/ts.sock --state=/tmp/ts/ts.state"
  alias dev-tailscale "go run tailscale.com/cmd/tailscale --socket=/tmp/ts/ts.sock"
  alias dev-alt-tailscaled "go run tailscale.com/cmd/tailscaled --tun=userspace-networking --socket=/tmp/ts/ts2.sock --state=/tmp/ts/ts2.state"
  alias dev-alt-tailscale "go run tailscale.com/cmd/tailscale --socket=/tmp/ts/ts2.sock"

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

  # Configure paths for Tailscale development
  set -x PATH "./tool" $PATH
end

# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/Users/rosszurowski/Library/Preferences/netlify/helper/path.fish.inc' && source '/Users/rosszurowski/Library/Preferences/netlify/helper/path.fish.inc'

# Bun
set -Ux BUN_INSTALL "/Users/rosszurowski/.bun"
set -px --path PATH "/Users/rosszurowski/.bun/bin"

