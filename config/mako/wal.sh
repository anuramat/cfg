#!/usr/bin/env bash

cat "$XDG_CONFIG_HOME/mako/input.conf" "$XDG_CACHE_HOME/wal/colors-mako.conf" >"$XDG_CONFIG_HOME/mako/config"
makoctl reload
