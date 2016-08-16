
TEMPLATES_DIR=`new directory`

_new_complete() {
	COMPREPLY=()
	local cur="${COMP_WORDS[COMP_CWORD]}"

	if [[ ${#COMP_WORDS[@]} -eq 2 ]]; then
		templates=`ls -1 ${TEMPLATES_DIR} | tr '\n' '\0' | xargs -0 -n 1 basename `
		COMPREPLY=($(compgen -W "${templates}" -- ${cur}))
	fi

	return 0
}

# Register _new_complete to provide completion for the following commands
complete -o nospace -F _new_complete new
