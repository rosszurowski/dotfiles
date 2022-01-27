function mkcd -d "Create and enter a directory"
  set dir "$argv[1]"
  if test (count $argv) -eq 0
    echo -e "Usage: mkcd \033[2m[directory]\033[0m"
  else if test -d $dir
    echo -e "\033[31mError:\033[0m Directory \"$dir\" already exists"
  else
    mkdir $dir && cd $dir
  end
end
