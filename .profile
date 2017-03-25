
export PATH="/Users/$(whoami)/Sites/dotfiles/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{path,exports,aliases,functions,prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load any computer-specific extensions to dotfiles
# These files should have a .local suffix, and will not be
# tracked by Git.
# for file in ~/.{profile,path,exports,prompt,aliases,functions}.local; do
# 	[ -r "$file" ] && [ -f "$file" ] && source "$file"
# done

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# Append to the Bash history file, rather than overwriting it
shopt -s histappend
# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
# Save all lines of a multiple-line command in the same history entry (allows easy re-editing of multi-line commands)
shopt -s cmdhist
# Do not autocomplete when accidentally pressing Tab on an empty line. (It takes forever and yields "Display all 15 gazillion possibilites?")
shopt -s no_empty_cmd_completion

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for Git, Make, and Pass
for file in $(brew --prefix)/etc/bash_completion.d/*.bash; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o default -o nospace -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
# Add tab completion `killall` with common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# Add RVM
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.yarn/bin:$PATH"
