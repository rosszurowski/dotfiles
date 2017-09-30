# navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# `ls` improvements
alias ls="ls -CF"
alias lsh="ls -fA"
alias lsa="ls -lhA"
alias sla="ls -lhA"

# get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update --system; sudo gem update'

# ip addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias internal-ip="ipconfig getifaddr en0 || ipconfig getifaddr en1"
alias ip-list="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# flush dns cache
alias flush="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
# Usage: `command-one && command-two && notify`
alias notify="tput bel"

# Keeps the computer awake until the completion of the command
# Usage: `caffine long-command`
alias caffeine="caffeinate -i"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder"

# Alias atom as e (for editor)
alias e='atom'

# Auto-corrections
alias h='history'
alias hist='history'

# Reload the shell (i.e. invoke as a login shell)
alias reload!=". ~/.zshrc"

# mkdir and cd in one command
mkcd () {
  if [ $# -eq 0 ]; then
    echo "Usage: mkcd \033[2m[directory]\033[0m"
  elif [ -d $1 ]; then
    echo "\033[31mError:\033[0m Directory \`$1\` already exists"
  else
    mkdir "$1" && cd "$1"
  fi
}
