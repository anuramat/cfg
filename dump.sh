#!/usr/bin/env bash
NEW_BREWFILE="new.Brewfile"
brew bundle dump --file "${NEW_BREWFILE}"
comm -13 <(sort Brewfile) <(sort "${NEW_BREWFILE}") >brewdiff
