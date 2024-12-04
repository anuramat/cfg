#!/usr/bin/env bash
__undistract_preexec() {
    __last_command_start_time=$(date +%s)
    __last_command="$1"
}
preexec_functions+=(__undistract_preexec)
__undistract() {
    [ -z "$__last_command_start_time" ] && return
    local diff="$(($(date +%s) - __last_command_start_time))"
    ((diff > 5)) && tput bel
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }__undistract
