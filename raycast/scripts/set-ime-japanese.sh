#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set IME to Japanese
# @raycast.mode silent
# @raycast.packageName Keyboard

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.author Ross Zurowski
# @raycast.authorURL https://github.com/rosszurowski
# @raycast.description Set your keyboard input method to Japanese.

./misc/switch-ime --name Japanese --method com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese
