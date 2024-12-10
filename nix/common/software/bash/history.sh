#!/usr/bin/env bash
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTTIMEFORMAT="[%F %T %z]"
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}history -a"
