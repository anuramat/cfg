#!/usr/bin/env sh

# number of commands stored in memory
export HISTSIZE=-1
# number of commands stored in file
export HISTFILESIZE=-1

# Locale
export LC_ALL="en_US.UTF-8"
# just in case, this is already defined in *.nix

export PAGER=less                                 # just in case, this is already defined somewhere in system level rc
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # I don't know how this works
# docs: It might also be necessary to set MANROFFOPT="-c" if you experience formatting problems.

# Vim
for editor in nvim vim nvi vi; do
	if command -v "$editor" >/dev/null 2>&1; then
		export VISUAL="$editor"
		break
	fi
done
export EDITOR="$VISUAL"
