#
# Variables
#
DIR       = $(dir $(lastword $(MAKEFILE_LIST)))
DOTFILES  = .aliases .exports .functions .profile .gitconfig .gitignore

#
# Tasks
#
install: $(DOTFILES)
	@rm -f $^
	@ln -s $^

.PHONY: install