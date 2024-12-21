#!/usr/bin/env bash

ours=$(sort -u "$1")
before=$(sort -u "$2")
theirs=$(sort -u "$3")

common=$(printf '%s\n' "$ours" "$theirs" | sort -u)
removed=$(printf '%s' "$before" | comm -23 - <(comm -12 <(printf '%s' "$ours") <(printf '%s' "$theirs")))
printf '%s' "$removed" | grep -vxF -f - <(printf '%s' "$common") | sort -u > "$1"
