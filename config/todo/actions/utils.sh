#!/usr/bin/env bash

linenr() {
  num=$1

  len=$(wc -l "$TODO_FILE" | cut -d ' ' -f 1)
  [ -z "$num" ] && num="$len"
  [[ $num =~ ^[1-9][0-9]*$ ]] || exit 1
  ((num > len)) && exit 1

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
  pieces=()
  while read -r tag; do
    pieces+=("$(TODOTXT_VERBOSE=0 $TODO_SH -"$symbol" -p ls "$tag" | tac | cat <(printf '%s\n---\n' "$tag") - | head -n "$max_tasks")")
  done < <($TODO_SH "$subcmd")

  n_pieces=${#pieces[@]}
  n_rows=$(((n_pieces + n_cols - 1) / n_cols))

  # this disables stretching on the last row by adding an empty cell
  for i in $(seq $((n_cols * n_rows - n_pieces))); do
    pieces+=("")
  done

  # use pr to columnate output
  for i in $(seq 0 $((n_rows - 1))); do
    printf '\n'
    subs=$(printf '<(printf %%s %q) ' "${pieces[@]:$((i * n_cols)):n_cols}")
    eval pr --omit-header --merge --width="$term_width" $subs
  done
}
