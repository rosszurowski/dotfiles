# Dotfiles

These files contain all the preferences for Mac OS X, Bash, and Git that you're used to. To set up a new computer, there's just a couple things you'll need to do.

## Installation

#### Using git

```bash
git clone https://github.com/rosszurowski/dotfiles.git && cd dotfiles && source bootstrap.sh
```

#### Git-free install

To get started without git, just run:

```bash
mkdir dotfiles && curl -L https://github.com/rosszurowski/dotfiles/tarball/master | tar zx -C dotfiles --strip-components 1 && cd dotfiles && source bootstrap.sh
```

#### Install Homebrew Formuale

It may be helpful to install some common [Homebrew](http://homebrew.sh) formulae once you've got Homebrew and the dotfiles installed.

```bash
brew bundle Brewfile
```

#### Updating Bash

You'll want to update your Bash to the latest version (which was installed by that Brewfile), by adding it to `/etc/shells`:

```bash
echo "/usr/local/bin/bash" >> /etc/shells
```

After that's done, change the default shell with:

```bash
chsh -s /usr/local/bin/bash
```

## Sensible OS X Defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
. ./.osx
```

Also, you'll want to install the XCode Developer Tools:

```bash
xcode-select --install
```

And [Homebrew](http://homebrew.sh) as well:

```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

## Other utilities

#### RVM

For managing Ruby versions:

```bash
\curl -sSL https://get.rvm.io | bash -s stable
```

#### Pow

For running basic Ruby servers:

```bash
curl get.pow.cx | sh
```

If you find that Pow is getting in the way of another web server (Apache, Nginx, etc.), create a `.powconfig` file and add the following to it:

```bash
export POW_DST_PORT=19999
```
If you want to redirect a localhost to a Pow server, just reverse proxy it.

#### Nginx

For web development:

```bash
brew tap josegonzalez/php
brew tap homebrew/dupes

brew install nginx
brew install php55 --with-fpm --without-apache --with-imap
```

You'll probably have to play around with getting those guys to run on startup


## Thanks

This was based almost entirely on [Mathias' dotfiles repo](https://github.com/mathiasbynens/dotfiles). Look there if you need help with this stuff.
