# Dotfiles

Preferences and config for my dev environment. A bunch of zsh, Git, and OS X scripts and utilities that I'm used to. Most interesting to others might be my [folder of utility scripts](#personal-utilities).

## Installation

```bash
curl https://raw.githubusercontent.com/rosszurowski/dotfiles/master/bootstrap.sh | bash
```

### Sensible Mac OS Defaults

When setting up a new Mac, you may want to set some sensible OS defaults:

```bash
script/setup-mac
```

### Installing font library

Once [the AWS CLI is set up](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html), restore the font library from the latest backup.

```bash
script/fonts-download
```

To make a new backup, run

```bash
script/fonts-upload
```

## Personal Utilities

The `bin/` folder has a number of handy personal bash commands I use regularly.

* `dns` allows quickly changing DNS servers from [Google DNS](https://developers.google.com/speed/public-dns/) to [Cloudflare DNS](https://cloudflare-dns.com) to network defaults. Handy for resetting DNS on public Wi-Fi networks that block custom DNS.
* `e` quickly opens my editor in the current directory or specified path.
* `encode` encodes video for the web using `ffmpeg`
* `journal` is my journaling utility, which creates date-timestamped files in [iA Writer](http://www.ia.net/writer).
* `uuid` gives me a UUID. Pairs well with `pbcopy` while programming.
* `wifi` is a utility to periodically disable Wi-Fi access so my computer is an "offline-by-default" machine. I find this helps me keep more focused while I work.
* `wifi-password` is a utility I took from somewhere to quickly get the password of the current Wi-Fi network. Easier than opening up Keychain Access.
* `wifi-signal-strength` is a way to triage your current network's bandwidth from the command line. Also taken from somewhere else.

## See also

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [yyx990803/dotfiles](https://github.com/yyx990803/dotfiles)
* [yoshuawuyts/dotfiles](https://github.com/yoshuawuyts/dotfiles)
