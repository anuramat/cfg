#!/usr/bin/env bash
osc133_prompt() {
    printf '\e]133;A\e\\'
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc133_prompt
