# Built-in commands {{{

timew_commands='
annotate
cancel
config
continue
day
delete
diagnostics
export
extensions
gaps
get
join
lengthen
modify
month
move
report
shorten
show
split
start
stop
summary
tag
tags
track
undo
untag
week
'

# }}}

# Custom commands {{{

timew_custom_commands='
cut
restart
restore
switch
'

# }}}

_timew_completion() {
	local results

	# Autocomplete command names
	if [[ ${#COMP_WORDS[@]} -le 2 ]]; then
		mapfile -t COMPREPLY < <(compgen -W "help ${timew_commands} ${timew_custom_commands}" -- "${COMP_WORDS[COMP_CWORD]:-}" || true)
		return 0
	fi

	# Autocomplete arguments of some commands
	case "${COMP_WORDS[1]}" in
		help)
			results="${timew_commands} dates dom durations hints ranges"
			;;
		*)
			return 0
			;;
	esac

	if [[ -n "${results:-}" ]]; then
		mapfile -t COMPREPLY < <(compgen -W "${results}" -- "${COMP_WORDS[COMP_CWORD]}" || true)
	fi
}

complete -F _timew_completion timew toki
