function src -d "Navigate to folders in the SRC directory"
  if test -z "$SRC"
    echo -e "\033[31mERROR:\033[0m \$SRC env var was not set"
    exit 1
  end

  if test (count $argv) -eq 0
    cd "$SRC" || exit
  end

  set dir "$argv[1]"
  set srcdir "$SRC/$dir"

  if test -d $srcdir
    cd "$srcdir"
  else
    echo -e "\033[31mERROR:\033[0m No directory \"$dir\""
  end
end
