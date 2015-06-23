
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:$PATH"
export PS1="\[\033[0;90m\]$ \[\033[0m\]"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{path,exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load any computer-specific extensions to dotfiles
# These files should have a .local suffix, and will not be
# tracked by Git.
for file in ~/.{profile,path,exports,aliases,functions}.local; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# Append to the Bash history file, rather than overwriting it
shopt -s histappend
# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
# Add tab completion `killall` with common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall
# Add tab completion for Git files and branches
completion="$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
[ -f $completion ] && source $completion
