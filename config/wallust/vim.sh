#!/usr/bin/env bash
set -e

main() {
  # reads .vim themes, writes terminal-sexy jsons to specified directory
  # skips dual (light+dark) themes for now TODO
  target_dir="$1"
  mkdir -p "$target_dir"

  vimdir=$(dirname "$(dirname "$(realpath "$(command -v nvim)")")")
  colordir="$vimdir/share/nvim/runtime/colors"

  while IFS= read -r -d '' filepath; do
    name=$(basename "$filepath" | sed 's/\.vim//')
    ansi=$(rg 'let\s+g:terminal_ansi_colors\s*=\s*(\[.*\])' "$filepath" -or '$1' \
      | tr "'" '"')
    (($(echo "$ansi" | wc -l) > 1)) && continue
    # original_name=$(rg '" Name:\s+(\S.*\S)\s*' "$filename" -or '$1')
    author=$(rg '" Author:\s+(\S.*\S)\s*' "$filepath" -or '$1')

    normal_line=$(rg 'hi\S*\s+Normal\s+' "$filepath")
    fg=$(echo "$normal_line" | rg 'guifg=(\S+)' -or '$1')
    bg=$(echo "$normal_line" | rg 'guibg=(\S+)' -or '$1')

    template='{"name": $name, "author": $author, "color": $ansi, "foreground": $fg, "background": $bg}'

    jq -n \
      --arg fg "$fg" \
      --arg bg "$bg" \
      --arg name "$name" \
      --arg author "$author" \
      --argjson ansi "$ansi" \
      "$template" > "$target_dir/$name.json"
  done < <(find "$colordir" -mindepth 1 -name '*.vim' -print0)
}

main "colorschemes"
