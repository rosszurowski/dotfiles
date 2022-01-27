# Completion for the `src` function. We need to put this in the `completions`
# folder because `src` is defined in the built-in completions too, and including
# it here is how we override it.

function _src_complete
  set prevdir $PWD
  cd $SRC
  ls
  cd $prevdir
end

complete --command src -f
complete --command src -a "(_src_complete)"
