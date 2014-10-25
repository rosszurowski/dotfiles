#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  for file in .{profile,path,exports,aliases,functions,gitignore,gitconfig}; do
    [ -r "$file" ] && [ -f "$file" ] && ln -sf "$(pwd)/$file" "$HOME/$file"
  done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
if [ $? -eq 0 ]; then
    echo "Done. Restart your terminal for the changes to take effect."
else
    echo "Some files had errors while linking. Please delete any existing files and try again."
fi
unset doIt;