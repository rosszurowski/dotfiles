#
# Variables
#
DIR         = $(dir $(lastword $(MAKEFILE_LIST)))
FILES       = .aliases .exports .functions .profile .prompt .gitconfig .gitignore .hyper.js .vimrc
DESTINATION = $(HOME)/
OVERRIDE    = .local
PREFIX     ?= $(shell brew --prefix)

DOTFILES    = $(addprefix $(DESTINATION), $(FILES))
EXISTING    = $(addprefix $(DESTINATION), $(wildcard .*$(OVERRIDE)))
LOCALS      = $(addsuffix $(OVERRIDE), $(DOTFILES))
COMPLETIONS = $(addprefix $(PREFIX)/etc/bash_completion.d/, git.bash make.bash)

ATOM        = $(addprefix $(DESTINATION), .atom .vim)

YELLOW = \033[0;33m
END    = \033[0m

#
# Tasks
#
install: clean $(DOTFILES) $(EXISTING) $(COMPLETIONS) $(ATOM)
	@echo "..."
	@echo "$(YELLOW)Done installing$(END)"

clean:
	@rm -f $(DOTFILES)
	@rm -f $(LOCALS)

#
# Targets
#

$(HOME)/%: %
	@ln -fs "$(realpath $<)" "$@"

$(HOME)/.%: %
	@ln -fs "$(realpath $<)" "$@"

$(PREFIX)/etc/bash_completion.d/%: ./autocomplete/%
	@mkdir -p "$(dir $@)"
	@ln -fs "$(realpath $<)" "$@"

atom/packages.txt: atom/packages
	@apm list --installed --bare > $@

.PHONY: clean
