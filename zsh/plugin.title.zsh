title_prompt_set_title () {
	# emacs terminal does not support settings the title
	(( ${+EMACS} )) && return

	# tell the terminal we are setting the title
	print -n '\e]0;'
	# show hostname if connected through ssh
	[[ -n $SSH_CONNECTION ]] && print -Pn '(%m) '
	case $1 in
		expand-prompt)
			print -Pn $2;;
		ignore-escape)
			print -rn $2;;
	esac
	# end set title
	print -n '\a'
}

title_prompt_precmd () {
  title_prompt_set_title 'ignore-escape' "$PWD:t"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd title_prompt_precmd
