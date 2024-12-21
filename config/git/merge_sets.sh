#!/usr/bin/env bash

ours=$(sort "$1")
before=$(sort "$2")
theirs=$(sort "$3")

common=$(printf '%s\n'"$ours" "$theirs" | sort -u)
removed=$(printf '%s' "$before" | comm -23 - <(comm -12 <(printf '%s' "$ours") <(printf '%s' "$theirs")))
merged=$(printf '%s' "$removed" | grep -vxF -f - <(printf '%s' "$common"))

printf '%s' "$merged"
