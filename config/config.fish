#!/usr/bin/env fish
if status is-interactive
  brew shellenv fish | source
  zoxide init fish --cmd j | source
  if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
    eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" hook $argv | source
  end
end
