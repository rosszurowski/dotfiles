#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Spotify to Apple Music
# @raycast.mode silent
# @raycast.packageName Spotify
#
# Optional parameters:
# @raycast.icon ./images/spotify-logo.png
#
# @Documentation:
# @raycast.description Converts a Spotify URL in your clipboard to an Apple Music URL.
# @raycast.author Ross Zurowski
# @raycast.authorURL https://github.com/rosszurowski

# Uses the song.link API to convert between the formats.

url=$(pbpaste)
curl -fsSL "https://api.song.link/v1-alpha.1/links?url=$url" | jq -r ".linksByPlatform.appleMusic.url" | pbcopy
echo "Copied to clipboard"
