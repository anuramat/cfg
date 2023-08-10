#!/usr/bin/env bash
# Uses __UTILS_OVERWRITE variable ("always"/any)

ensure_path() {
	# $1 -- target path
	local -r target="$1"

	[ -d "${target}" ] && return
	mkdir -p "${target}" || {
		echo "[cfg.fail] create path \"${target}\""
		return 1
	}
	echo "[cfg.write] created path \"$1\""
}

ensure_string() {
	# $1 -- string
	# $2 -- target file
	local -r string="$1"
	local -r target="$2"

	grep -Fq "${string}" "${target}" && return
	ensure_path "$(dirname "${target}")" || return 1
	echo "${string}" >>"${target}" || {
		echo "[cfg.fail] append string \"${string}\" to ${target}"
		return 1
	}
	echo "[cfg.write] appended \"${string}\" to ${target}"
}

make_symlink() {
	# $1 -- source file
	# $2 -- target file/directory
	local -r original="$(realpath "$1")"
	local target="$2"

	[ -d "${target}" ] && target="${target}/$(basename "${original}")"
	[ -e "${target}" ] && { try_overwrite "${target}" || return 1; }
	ln -sf "${original}" "${target}" || {
		echo "[cfg.fail] make symlink @ \"${target}\""
		return 1
	}
	echo "[cfg.write] created symlink @ \"${target}\""
}

install2folder() {
	local -r original="$(realpath "$1")"
	local -r target_dir="$2"

	[ -e "$1" ] || {
		echo "[cfg.fail] file \"$1\" not found!"
		return 1
	}

	ensure_path "${target_dir}" || return 1
	install2file "${original}" "${target_dir}"
}

install2file() {
	# $1 -- source file
	# $2 -- target file
	local -r original="$(realpath "$1")"
	local -r target="$2"
	local -r target_dir="$(dirname "$2")"

	git check-ignore "${original}" >/dev/null 2>&1 && {
		return
	}

	[ -e "$1" ] || {
		echo "[cfg.fail] file \"$1\" not found!"
		return 1
	}

	ensure_path "${target_dir}" || return 1
	make_symlink "${original}" "${target}" || return 1
}

set_shell() {
	local -r shell="$(dirname "$1")/$(basename "$1")"

	[ "${SHELL}" = "${shell}" ] && return
	[ -f "${shell}" ] || {
		echo "[cfg.fail] shell \"${shell}\" not found"
		return 1
	}
	sudo bash -c "$(declare -f ensure_path); $(declare -f ensure_string); ensure_string \"${shell}\" /etc/shells"
	chsh -s "${shell}"
}

continue_prompt() {
	local -r prompt="$1"
	while true; do
		read -rp "${prompt} (y/n): " choice
		case "${choice}" in
			y | Y)
				return 0
				;;
			*)
				return 1
				;;
		esac
	done
}

try_overwrite() {
	# $1 -- target
	local -r target="$1"
	[ "${__UTILS_OVERWRITE}" = "always" ] || continue_prompt "overwrite \"${target}\"?" || return 1
	rm -rf "${target}" || return 1
}

dotfilify() {
	# $1 -- original name/path
	basename "$1" | perl -pe 's/(.*)\..*/.\1/'
}
