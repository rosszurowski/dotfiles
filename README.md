# Dotfiles

These files contain all the preferences for Mac OS X, Bash, and Git that you're used to. To set up a new computer, there's just a couple things you'll need to do.

## Installation

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

Finally, just symlink the dotfiles that you want to your home directory like so:

```
ln -s ./.profile ~/.profile
```

## Sensible OS X Defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```
. ./.osx
```

## Other utilities

#### RVM

For managing Ruby versions:

```
\curl -sSL https://get.rvm.io | bash -s stable
```

#### Pow

For running basic Ruby servers:

```
curl get.pow.cx | sh
```

#### Nginx

For web development:

```
brew tap josegonzalez/php
brew tap homebrew/dupes

brew install nginx
brew install php55 --with-fpm --without-apache --with-imap
```

You'll probably have to play around with getting those guys to run on startup