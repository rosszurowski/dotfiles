
fnKeys=('^[OP' '^[OQ' '^[OR' '^[OS' '^[[15~' '^[[17~' '^[[18~' '^[[19~' '^[[20~' '^[[21~' '^[[23~' '^[[24~')
touchBarState=''
npmScripts=()
lastPackageJsonPath=''

git_current_branch () {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

pecho () {
  if [ -n "$TMUX" ]
  then
    echo -ne "\ePtmux;\e$*\e\\"
  else
    echo -ne $*
  fi
}

tbecho () {
  pecho "\033]1337;$*\a"
}

function _clearTouchbar () {
  tbecho "PopKeyLabels"
}

function _unbindTouchbar () {
  for fnKey in "$fnKeys[@]"; do
    bindkey -s "$fnKey" ''
  done
}

function _displayDefault () {
  _clearTouchbar
  _unbindTouchbar

  touchBarState=''

  # current dir
  tbecho "SetKeyLabel=F1=$(echo $(pwd) | awk -F/ '{print $(NF)}')"
  bindkey -s "${fnKeys[1]}" 'ls \n'

  # git status
  command git rev-parse --is-inside-work-tree &>/dev/null || return
  if [[ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]]; then

    # Ensure the index is up to date.
    git update-index --really-refresh -q &>/dev/null

    tbecho "SetKeyLabel=F2=⎇ $(git_current_branch)"
    bindkey "${fnKeys[2]}" '_displayGitBranches'
  fi

  if [[ -f package.json ]]; then
    tbecho "SetKeyLabel=F3=⌁ npm scripts"
    bindkey "${fnKeys[3]}" _displayNpmScripts
  fi
}

function _displayGitBranches () {
  _clearTouchbar
  _unbindTouchbar

  branches=($(git for-each-ref --format='%(refname:short)' refs/heads/))
  touchBarState='git'

  fnKeysIndex=1
  for branch in "$branches[@]"; do
    fnKeysIndex=$((fnKeysIndex + 1))
    bindkey -s $fnKeys[$fnKeysIndex] "git checkout $branch; _displayDefault \n"
    tbecho "SetKeyLabel=F$fnKeysIndex=$branch"
  done

  tbecho "SetKeyLabel=F1=Cancel"
  bindkey "${fnKeys[1]}" _displayDefault
}

function _displayNpmScripts () {
  # find available npm run scripts only if new directory
  if [[ $lastPackageJsonPath != $(echo "$(pwd)/package.json") ]]; then
    lastPackageJsonPath=$(echo "$(pwd)/package.json")
    npmScripts=($(node -e "console.log(Object.keys($(npm run --json)).filter(name => !name.includes(':')).sort((a, b) => a.localeCompare(b)).filter((name, idx) => idx < 12).join(' '))"))
  fi

  _clearTouchbar
  _unbindTouchbar

  touchBarState='npm'

  fnKeysIndex=1
  for npmScript in "$npmScripts[@]"; do
    fnKeysIndex=$((fnKeysIndex + 1))
    bindkey -s $fnKeys[$fnKeysIndex] "_displayDefault; yarn $npmScript \n"
    tbecho "SetKeyLabel=F$fnKeysIndex=$npmScript"
  done

  tbecho "SetKeyLabel=F1=Cancel"
  bindkey "${fnKeys[1]}" _displayDefault
}

zle -N _displayDefault
zle -N _displayGitBranches
zle -N _displayNpmScripts

precmd_iterm_touchbar() {
  if [[ $touchBarState == 'git' ]]; then
    _displayGitBranches
  elif [[ $touchBarState == 'npm' ]]; then
    _displayNpmScripts
  else
    _displayDefault
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_iterm_touchbar
