# Dotfiles

These files contain all the preferences for Mac OS X, Bash, and Git that I'm used to. To set up a new computer, there's just a couple things you'll need to do.

## Installation

```bash
curl https://raw.githubusercontent.com/rosszurowski/dotfiles/master/bootstrap.sh | bash
```

## Terminal

![Base16 Ocean Theme](https://cloud.githubusercontent.com/assets/303731/7348055/29549e72-ecbc-11e4-9fe2-ee416a92ea48.gif)

In order to setup the terminal as usual, you'll want to download and install [Input Mono Narrow](http://input.fontbureau.com/download/?customize&fontSelection=whole&a=0&g=0&i=serif&l=serif&zero=0&asterisk=0&braces=0&preset=default&line-height=1.2&accept=I+do), with the specific set of configurations in that link.

Once you've done that, just download [base16-ocean.dark.terminal](https://github.com/rosszurowski/dotfiles/blob/master/terminal/base16-ocean.dark.terminal) and set it to your default. All done!

## Sensible OS X Defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
. ./.osx
```

## Moving your dotfiles

If you ever move the dotfiles to another location, you can relink them by changing to the cloned directory and running:

```bash
make install
```

## Thanks

Many ideas in here were taken from [Mathias'](https://github.com/mathiasbynens/dotfiles) and [Evan You's](https://github.com/yyx990803/dotfiles) dotfile repos. Look there if you need help with this stuff.
