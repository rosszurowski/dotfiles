#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disable Tailscale Flag
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "flag-name", "optional": false}

trash "$HOME/trusted-testers/${1}/example.com"
