# Dotfiles

These files contain all the preferences for Mac OS X, Bash, and Git that you're used to. To set up a new computer, there's just a couple things you'll need to do.

### Installation

First off, you'll want to install the XCode Developer Tools if you don't already have them. To get it, just run:

```
xcode-select --install
```

Next up, [Homebrew](http://brew.sh/):

```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

Then, [download this repo as a zip](https://github.com/rosszurowski/dotfiles/archive/master.zip) and run the contained `Brewfile` with:

```
brew bundle Brewfile
```

You'll want to update your Bash to the latest version (which was installed by that Brewfile), by adding `/usr/local/bin/bash` to `/etc/shells`.

After that's done, change the default shell with:

```
chsh -s /usr/local/bin/bash
```

### Other utilities

##### RVM

For managing Ruby versions:

```

```

##### Pow

For running basic Ruby servers:

```

```