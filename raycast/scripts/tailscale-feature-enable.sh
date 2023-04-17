#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Enable Tailscale Flag
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "flag-name", "optional": false}

mkdir -p "$HOME/trusted-testers/${1}"
touch "$HOME/trusted-testers/${1}/example.com"
