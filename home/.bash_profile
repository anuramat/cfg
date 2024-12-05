#!/usr/bin/env bash
. "$HOME/.bashrc"

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    shopt -s execfail
    exec sway
    exec sway --unsupported-gpu
    logout
fi
