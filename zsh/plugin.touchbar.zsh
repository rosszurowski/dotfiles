
fnKeys=('^[OP' '^[OQ' '^[OR' '^[OS' '^[[15~' '^[[17~' '^[[18~' '^[[19~' '^[[20~' '^[[21~' '^[[23~' '^[[24~')
touchBarState=''

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

function _clearTouchbar () {
  pecho "\033]1337;PopKeyLabels\a"
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
  pecho "\033]1337;SetKeyLabel=F1=$(echo $(pwd) | awk -F/ '{print $(NF-1)"/"$(NF)}')\a"
  bindkey -s '^[OP' 'ls \n'

  # git status
  command git rev-parse --is-inside-work-tree &>/dev/null || return
  if [[ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]]; then

    # Ensure the index is up to date.
    git update-index --really-refresh -q &>/dev/null

    pecho "\033]1337;SetKeyLabel=F2=⎇ $(git_current_branch)\a"
    bindkey '^[OQ' '_displayGitBranches'
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
    bindkey $fnKeys[$fnKeysIndex] "_displayDefault; git checkout $branch \n"
    pecho "\033]1337;SetKeyLabel=F$fnKeysIndex=$branch\a"
  done

  pecho "\033]1337;SetKeyLabel=F1=Cancel\a"
  bindkey "${fnKeys[1]}" _displayDefault
}

zle -N _displayDefault
zle -N _displayGitBranches

precmd_iterm_touchbar() {
  if [[ $touchBarState == 'git' ]]; then
    _displayGitBranches
  else
    _displayDefault
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd precmd_iterm_touchbar
