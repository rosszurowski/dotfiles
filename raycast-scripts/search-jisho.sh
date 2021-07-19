#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Jisho.org
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon ./images/jisho.png
# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }

open "https://jisho.org/search/${1}"
