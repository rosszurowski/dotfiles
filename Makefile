#
# Variables
#
DIR        = $(dir $(lastword $(MAKEFILE_LIST)))
FILES      = .aliases .exports .functions .profile .gitconfig .gitignore
LOCAL_EXT  = .local

DOTFILES   = $(addprefix $(HOME)/, $(FILES))

#
# Tasks
#
install: $(DOTFILES)
	@echo "Done installing"

#
# Targets
#

$(HOME)/%: %
	@rm -f "$@"
	@rm -f "$@$(LOCAL_EXT)"
	@ln -fs "$(realpath $<)" "$@"
	@if [ -f "$<$(LOCAL_EXT)" ]; then ln -fs "$(realpath $<)$(LOCAL_EXT)" "$@$(LOCAL_EXT)"; fi