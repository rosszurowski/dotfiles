# Dotfiles

These files contain all the preferences for Mac OS X, Bash, and Git that you're used to. To set up a new computer, there's just a couple things you'll need to do.

### Installation

First off, you'll want to install the XCode Developer Tools and [Homebrew](http://brew.sh/) if you don't already have them. To get it, just run:

```
# First, the developer tools
xcode-select --install
# Then Homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

Next up, [download this repo as a zip](https://github.com/rosszurowski/dotfiles/archive/master.zip) and 

You'll want to update your Bash version, which can be done by adding `/usr/local/bin/bash` to `/etc/shells`, and then change the default shell with:

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