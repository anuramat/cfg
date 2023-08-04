#!/usr/bin/env bash
# shellcheck disable=SC2139 # That's exactly the behaviour I want
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="$EDITOR"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Paths ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin${PATH:+:$PATH}"
export PATH="/opt/homebrew/bin${PATH:+:$PATH}"
eval "$(brew shellenv bash)"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
default_exa="exa --group-directories-first --group --icons --header --git"
alias f="nvim"
alias j="z"
alias ls="$default_exa"
alias ll="$default_exa --long"
alias la="$default_exa --long --all"
alias tree="$default_exa --tree"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~ External requirements ~~~~~~~~~~~~~~~~~~~~~~~~~~ #
export _ZO_RESOLVE_SYMLINKS="1"
eval "$(zoxide init bash --cmd j)"
# shellcheck disable=SC1091 # SC sometimes can't follow paths
[ -f ~/.fzf.bash ] && source "$HOME/.fzf.bash"
# Preview file content using bat
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'tree {}'"
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
gitprompt() {
  # Thanks GPT TODO understand hehe
  if [ -d .git ] || git rev-parse --git-dir >/dev/null 2>&1; then
    repo_name=$(basename "$(git rev-parse --show-toplevel)")
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -z "$branch" ]; then
      branch=$(git rev-parse --short HEAD 2>/dev/null)
    fi
    echo "  ~  $repo_name/$branch"
  else
    echo ""
  fi
}
PS1='\n$PWD$(gitprompt)\n'
PS2='│'
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Conda init ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
# shellcheck disable=SC2181 # I don't feel like fixing this
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
    . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
  else
    export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
  fi
fi
unset __conda_setup
