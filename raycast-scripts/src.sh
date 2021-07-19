#!/bin/bash

# Dependency: This script requires `code` to be installed.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title src
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon ⌨️
# @raycast.argument1 { "type": "text", "placeholder": "Directory" }
# @raycast.author Ross Zurowski
# @raycast.authorURL https://github.com/rosszurowski

# Documentation:
# @raycast.description Open a ~/Sites directory in VS Code

path="$HOME/Sites/${1}"
# shellcheck disable=SC2088
human_path="~/Sites/${1}"

if [ ! -d "$path" ]; then
  echo "No directory at $human_path"
  exit 1
fi

code "$path"
echo "Opened $human_path"
