# Dotfiles

Preferences and config for my dev environment. A bunch of zsh, Git, and OS X scripts and utilities that I'm used to.

## Installation

To be updated...

## Terminal

![Base16 Ocean Theme](https://cloud.githubusercontent.com/assets/303731/7348055/29549e72-ecbc-11e4-9fe2-ee416a92ea48.gif)

In order to setup the terminal as usual, you'll want to download and install [Input Mono Narrow](http://input.fontbureau.com/build/?customize&fontSelection=whole&a=0&g=0&i=serif&l=serif&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do), with the specific set of configurations in that link.

## Sensible OS X Defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
. ./.osx
```

## Installing font library

Once [the AWS CLI is set up](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html), restore the font library from the latest backup.

```bash
curl $(aws s3 presign s3://rosszurowski-backup/fonts.zip) > fonts.zip
unzip fonts.zip
```

You can then click on the font files to install them, or automatically install them with:

```bash
mv ./Fonts/* ~/Library/Fonts/
```

## See also

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [yyx990803/dotfiles](https://github.com/yyx990803/dotfiles)
* [yoshuawuyts/dotfiles](https://github.com/yoshuawuyts/dotfiles)
