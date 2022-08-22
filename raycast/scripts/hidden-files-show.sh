#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show Hidden Files
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 📂

# Documentation:
# @raycast.description Shows hidden files in Finder

set -e

defaults write com.apple.finder AppleShowAllFiles TRUE
killall Finder
