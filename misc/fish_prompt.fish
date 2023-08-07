function fish_prompt --description 'Write out the prompt'

  set -l last_status $status
  set -l normal (set_color normal)

  # Separate command-output blocks
  echo ""

  # Since we display the prompt on a new line allow the directory names to be longer.
  set -q fish_prompt_pwd_dir_length
  or set -lx fish_prompt_pwd_dir_length 0

  # Show non-zero return codes
  set -l prompt_status ""
  if test $last_status -ne 0
    set prompt_status " "(set_color $fish_color_error)"["$last_status"]"$normal
  end
  
  # First line
  echo -s " " (set_color $fish_color_cwd) (prompt_pwd) (set_color brpurple) (fish_vcs_prompt) $prompt_status
  # Second line
  echo -ns " " $normal

end
