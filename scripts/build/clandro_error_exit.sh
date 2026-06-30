# shellcheck shell=bash
clandro_error_exit() {
	if (( $# )); then
		printf 'ERROR: %s\n' "$*"
	else # Read from stdin.
		printf '%s\n' "$(cat -)"
	fi
	exit 1
} >&2
