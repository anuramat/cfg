#!/bin/sh

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && command -v sway &>/dev/null; then
if lspci | grep -iq nvidia; then
	exec sway --unsupported-gpu
fi
exec sway
fi
