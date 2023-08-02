#!/usr/bin/env fish
if status is-interactive
  eval "$(brew shellenv fish)"
  eval "$(zoxide init fish)"
  if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
    eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" hook $argv | source
  end
end
