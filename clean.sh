#!/bin/bash
# clean.sh - clean everything.
set -e -u

CLANDRO_SCRIPTDIR=$(cd "$(realpath "$(dirname "$0")")"; pwd)

# Store pid of current process in a file for docker__run_docker_exec_trap
. "$CLANDRO_SCRIPTDIR/scripts/utils/docker/docker.sh"; docker__create_docker_exec_pid_file

# Get variable CGCT_DIR
. "$CLANDRO_SCRIPTDIR/scripts/properties.sh"

# Checking if script is running on Android with 2 different methods.
# Needed for safety to prevent execution of potentially dangerous
# operations such as 'rm -rf /data/*' on Android device.
if [ "$(uname -o)" = "Android" ] || [ -e "/system/bin/app_process" ]; then
	CLANDRO_ON_DEVICE_BUILD=true
else
	CLANDRO_ON_DEVICE_BUILD=false
fi

if [ "$(id -u)" = "0" ] && [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
	echo "On-device execution of this script as root is disabled."
	exit 1
fi

# Read settings from .termuxrc if existing
test -f "$HOME/.termuxrc" && . "$HOME/.termuxrc"
: "${CLANDRO_TOPDIR:="$HOME/.clandro-build"}"
: "${TMPDIR:=/tmp}"
export TMPDIR

# Lock file. Same as used in build-package.sh.
CLANDRO_BUILD_LOCK_FILE="${TMPDIR}/.clandro-build.lck"
if [ ! -e "$CLANDRO_BUILD_LOCK_FILE" ]; then
	touch "$CLANDRO_BUILD_LOCK_FILE"
fi

{
	if ! flock -n 5; then
		echo "Not cleaning build directory since you have unfinished build running."
		exit 1
	fi

	if [ -d "$CLANDRO_TOPDIR" ]; then
		chmod +w -R "$CLANDRO_TOPDIR" || true
	fi

	# For on-device build cleanup Termux app data directory shouldn't be erased.
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		for variable_name in CLANDRO__PREFIX CLANDRO_APP__DATA_DIR CGCT_DIR; do
			variable_value="${!variable_name:-}"
			if [[ ! "$variable_value" =~ ^(/[^/]+)+$ ]]; then
				echo "The $variable_name '$variable_value' is not an absolute path under rootfs '/' while running 'clean.sh'." 1>&2
				exit 1
			fi
		done

		# If `CLANDRO__PREFIX` is under `CLANDRO_APP__DATA_DIR`, then
		# just delete the entire `CLANDRO_APP__DATA_DIR`. Otherwise,
		# only delete `CLANDRO__PREFIX` since its parent directories could
		# be a critical directory in `CLANDRO_REGEX__INVALID_TERMUX_PREFIX_PATHS`.
		# This should not be an issue as package files are only packed
		# from `CLANDRO_PREFIX_CLASSICAL` via `clandro_step_copy_into_massagedir()`.
		if [[ "$CLANDRO__PREFIX" == "$CLANDRO_APP__DATA_DIR" ]] || \
			[[ "$CLANDRO__PREFIX" == "$CLANDRO_APP__DATA_DIR/"* ]]; then
			deletion_dir="$CLANDRO_APP__DATA_DIR"
		else
			deletion_dir="$CLANDRO__PREFIX"
		fi

		if [[ -e "$deletion_dir" ]]; then
			if [[ ! -d "$deletion_dir" ]]; then
				echo "A non-directory file exists at deletion directory '$deletion_dir' for CLANDRO__PREFIX while running 'clean.sh'." 1>&2
				exit 1
			fi

			# If deletion directory is under rootfs `/` or not accessible
			# by current user, like the `builder` user in Clandro docker
			# cannot access root owned directories.
			if [[ ! -r "$deletion_dir" ]] || [[ ! -w "$deletion_dir" ]] || [[ ! -x "$deletion_dir" ]]; then
				echo "The deletion directory '$deletion_dir' for CLANDRO__PREFIX is not readable, writable or searchable while running 'clean.sh'." 1>&2
				echo "Try running 'clean.sh' with 'sudo'." 1>&2
				exit 1
			fi

			# Escape '\$[](){}|^.?+*' with backslashes.
			cgct_dir_escaped="$(printf "%s" "$CGCT_DIR" | sed -zE -e 's/[][\.|$(){}?+*^]/\\&/g')"
			find "$deletion_dir" -mindepth 1 -regextype posix-extended ! -regex "^$cgct_dir_escaped(/.*)?" -delete 2>/dev/null || true
		fi

		# Remove list of built packages.
		rm -Rf "/data/data/.built-packages"
	fi

	# unmount overlayfs before we remove the parent directory
	[[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]] && [ -d "$CLANDRO_TOPDIR" ] && for dir in $(find "$CLANDRO_TOPDIR" -type d); do
		if mountpoint -q "$dir"; then
			umount "$dir"
		fi
	done

	# We can't use rm -Rf "$CLANDRO_TOPDIR" in case the "$CLANDRO_TOPDIR" is mounted as a Docker volume
	if [ -d "$CLANDRO_TOPDIR" ]; then
		find "$CLANDRO_TOPDIR" -type f,l,b,c -delete
		find "$CLANDRO_TOPDIR" -type d ! -path "$CLANDRO_TOPDIR" -delete
	fi
} 5< "$CLANDRO_BUILD_LOCK_FILE"
