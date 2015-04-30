#
# Variables
#
DIR       = $(dir $(lastword $(MAKEFILE_LIST)))
DOTFILES  = .aliases .exports .functions .profile .gitconfig .gitignore

#
# Tasks
#
install: $(addprefix $(HOME)/,$(DOTFILES))
	@echo "Done installing"

#
# Targets
#
$(HOME)/%: %
	@rm -f $@
	@ln -fs $(realpath $<) $@
