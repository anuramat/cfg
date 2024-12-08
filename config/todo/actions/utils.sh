#!/usr/bin/env bash

linenr_handler() {
	case "$?" in
	1)
		echo "Invalid task number"
		exit 1
		;;
	2)
		echo "Cancelled"
		exit 2
		;;
	*)
		echo "Unexpected error"
		;;
	esac
}

linenr() {
	num=$1
	fzf=$2

	len=$(wc -l "$TODO_FILE" | cut -d ' ' -f 1)
	[ -z "$num" ] && {
		[ -n "$fzf" ] && command -v fzf &>/dev/null && {
			num=$($TODO_SH -p command ls | fzf --preview= | cut -d ' ' -f 1)
			[ -z "$num" ] && return 2
			num=$((10#$num))
		} || num="$len"
	}
	[[ $num =~ ^[1-9][0-9]*$ ]] || return 1
	((num > len)) && return 1

	echo "$num"
}

view_by_tag() {
	symbol="$1"
	subcmd="$2"

	max_tasks="10"
	min_desc_width="30"

	term_width=$(tput cols)
	n_cols=$((term_width / min_desc_width))

	# read tasks by tag
	tasks=()
	while read -r tag; do
		tasks+=("$(TODOTXT_VERBOSE=0 $TODO_SH -"$symbol" -p command ls "$tag" | tac | cat <(printf '%s\n---\n' "$tag") - | head -n "$max_tasks")")
	done < <(
		$TODO_SH command "$subcmd"
		echo -"$symbol" # unfiled tasks
	)

	n_pieces=${#tasks[@]}
	n_rows=$(((n_pieces + n_cols - 1) / n_cols))

	# this disables stretching on the last row by adding an empty cell
	for i in $(seq $((n_cols * n_rows - n_pieces))); do
		tasks+=("")
	done

	# use pr to columnate output
	for i in $(seq 0 $((n_rows - 1))); do
		printf '\n'
		subs=$(printf '<(printf %%s %q) ' "${tasks[@]:$((i * n_cols)):n_cols}")
		eval pr --omit-header --merge --width="$term_width" $subs
	done
}
