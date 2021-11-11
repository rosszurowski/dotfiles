#!/usr/bin/env bash 

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set IME to English
# @raycast.mode silent
# @raycast.packageName Keyboard

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Set your keyboard input method to English.

./misc/switch-ime --name English --method com.apple.keylayout.US
