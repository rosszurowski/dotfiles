# Completion for the `key` function.

function _key_complete
  set prevdir $PWD
  cd "$DOTFILES/keys"
  ls
  cd $prevdir
end

complete --command key -f
complete --command key -a "(_key_complete)"
