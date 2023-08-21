#!/usr/bin/env bash
set -e

while getopts 'g:' opt; do
	case "${opt}" in
		g)
			__GOBINFILE="${OPTARG}"
			;;
		:)
			echo "[cfg.fail] option requires an argument"
			exit 1
			;;
		?)
			echo "[cfg] illegal option"
			exit 1
			;;
		*)
			echo "[cfg] error in getopts"
			exit 1
			;;
	esac
	shift
done

. lib/utils.sh

install_gobins "${__GOBINFILE}"
brew analytics off && brew bundle install
