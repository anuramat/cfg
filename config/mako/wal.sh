#!/usr/bin/env bash

cd "$XDG_CONFIG_HOME/mako" || exit
cat main.conf generated-colors.conf apps.conf >"$path/config"
makoctl reload
