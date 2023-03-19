#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set IME to Korean
# @raycast.mode silent
# @raycast.packageName Keyboard

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Set your keyboard input method to Korean.

./misc/switch-ime --name Korean --method "com.apple.inputmethod.Korean.2SetKorean"
