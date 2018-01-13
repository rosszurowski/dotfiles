# Dotfiles

Preferences and config for my dev environment. A bunch of zsh, Git, and OS X scripts and utilities that I'm used to.

## Installation

```bash
curl https://raw.githubusercontent.com/rosszurowski/dotfiles/master/bootstrap.sh | bash
```

To be updated...

## Terminal

![Terminal theme](https://user-images.githubusercontent.com/303731/30013218-1e176d84-90fa-11e7-985a-95328d015bee.png)

The above scripts will automatically configure [iTerm](https://www.iterm2.com/) with the [Nord theme](https://github.com/arcticicestudio/nord-iterm2) and the [Input Mono Narrow](http://input.fontbureau.com/build/?customize&fontSelection=whole&a=0&g=0&i=serif&l=serif&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do) typeface.

## Sensible Mac OS Defaults

When setting up a new Mac, you may want to set some sensible OS defaults:

```bash
script/setup-mac
```

## Installing font library

Once [the AWS CLI is set up](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html), restore the font library from the latest backup.

```bash
script/fonts-download
```

To make a new backup, run

```bash
script/fonts-upload
```

## See also

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [yyx990803/dotfiles](https://github.com/yyx990803/dotfiles)
* [yoshuawuyts/dotfiles](https://github.com/yoshuawuyts/dotfiles)
