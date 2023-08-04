#!/usr/bin/env fish
/opt/homebrew/bin/brew shellenv fish | source
if status is-interactive
  zoxide init fish --cmd j | source
  if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
    eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" hook $argv | source
  end
end
