#!/usr/bin/env bash
prompt_marker() {
    printf '\e]133;A\e\\'
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }prompt_marker
