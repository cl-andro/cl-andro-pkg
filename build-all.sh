#!/bin/bash
# build-all.sh - script to build all packages with a build order specified by buildorder.py

set -e -u -o pipefail

CLANDRO_SCRIPTDIR=$(cd "$(realpath "$(dirname "$0")")"; pwd)

# Store pid of current process in a file for docker__run_docker_exec_trap
source "$CLANDRO_SCRIPTDIR/scripts/utils/docker/docker.sh"; docker__create_docker_exec_pid_file

if [ "$(uname -o)" = "Android" ] || [ -e "/system/bin/app_process" ]; then
	echo "On-device execution of this script is not supported."
	exit 1
fi

# Read settings from .termuxrc if existing
test -f "$HOME"/.termuxrc && . "$HOME"/.termuxrc
: ${CLANDRO_TOPDIR:="$HOME/.clandro-build"}
: ${CLANDRO_ARCH:="aarch64"}
: ${CLANDRO_FORMAT:="debian"}
: ${CLANDRO_DEBUG_BUILD:=""}
: ${CLANDRO_INSTALL_DEPS:="-s"}
# Set CLANDRO_INSTALL_DEPS to -s unless set to -i

_show_usage() {
	echo "Usage: ./build-all.sh [-a ARCH] [-d] [-i] [-o DIR] [-f FORMAT]"
	echo "Build all packages."
	echo "  -a The architecture to build for: aarch64(default), arm, i686, x86_64 or all."
	echo "  -d Build with debug symbols."
	echo "  -i Build dependencies."
	echo "  -o Specify deb directory. Default: debs/."
	echo "  -f Specify format pkg: debian(default) or pacman."
	exit 1
}

while getopts :a:hdio:f: option; do
case "$option" in
	a) CLANDRO_ARCH="$OPTARG";;
	d) CLANDRO_DEBUG_BUILD='-d';;
	i) CLANDRO_INSTALL_DEPS='-i';;
	o) CLANDRO_OUTPUT_DIR="$(realpath -m "$OPTARG")";;
	f) CLANDRO_FORMAT="$OPTARG";;
	h) _show_usage;;
	*) _show_usage >&2 ;;
esac
done
shift $((OPTIND-1))
if [ "$#" -ne 0 ]; then _show_usage; fi

case "$CLANDRO_ARCH" in
	all|aarch64|arm|i686|x86_64);;
	*) echo "ERROR: Invalid arch '$CLANDRO_ARCH'" 1>&2; exit 1;;
esac

case "$CLANDRO_FORMAT" in
	debian|pacman);;
	*) echo "ERROR: Invalid format '$CLANDRO_FORMAT'" 1>&2; exit 1;;
esac

BUILDSCRIPT=$(dirname "$0")/build-package.sh
BUILDALL_DIR=$CLANDRO_TOPDIR/_buildall-$CLANDRO_ARCH
BUILDORDER_FILE=$BUILDALL_DIR/buildorder.txt
BUILDSTATUS_FILE=$BUILDALL_DIR/buildstatus.txt

if [ -e "$BUILDORDER_FILE" ]; then
	echo "Using existing buildorder file: $BUILDORDER_FILE"
else
	mkdir -p "$BUILDALL_DIR"
	"$CLANDRO_SCRIPTDIR/scripts/buildorder.py" > "$BUILDORDER_FILE"
fi
if [ -e "$BUILDSTATUS_FILE" ]; then
	echo "Continuing build-all from: $BUILDSTATUS_FILE"
fi

exec &>	>(tee -a "$BUILDALL_DIR"/ALL.out)
trap 'echo ERROR: See $BUILDALL_DIR/${PKG}.out' ERR

while read -r PKG PKG_DIR; do
	# Check build status (grepping is a bit crude, but it works)
	if [ -e "$BUILDSTATUS_FILE" ] && grep -q "^$PKG\$" "$BUILDSTATUS_FILE"; then
		echo "Skipping $PKG"
		continue
	fi

	# Start building
	if [ -n "${CLANDRO_DEBUG_BUILD}" ]; then
		echo "\"$BUILDSCRIPT\" -a \"$CLANDRO_ARCH\" $CLANDRO_DEBUG_BUILD --format \"$CLANDRO_FORMAT\" --library $(test "${PKG_DIR%/*}" = "gpkg" && echo "glibc" || echo "bionic") ${CLANDRO_OUTPUT_DIR+-o $CLANDRO_OUTPUT_DIR} $CLANDRO_INSTALL_DEPS \"$PKG_DIR\""
	fi

	echo -n "Building $PKG... "
	BUILD_START=$(date "+%s")
	"$BUILDSCRIPT" -a "$CLANDRO_ARCH" $CLANDRO_DEBUG_BUILD --format "$CLANDRO_FORMAT" \
		--library $(test "${PKG_DIR%/*}" = "gpkg" && echo "glibc" || echo "bionic") \
		${CLANDRO_OUTPUT_DIR+-o $CLANDRO_OUTPUT_DIR} $CLANDRO_INSTALL_DEPS "$PKG_DIR" \
		&> "$BUILDALL_DIR"/"${PKG}".out
	BUILD_END=$(date "+%s")
	BUILD_SECONDS=$(( BUILD_END - BUILD_START ))
	echo "done in $BUILD_SECONDS sec"

	# Update build status
	echo "$PKG" >> "$BUILDSTATUS_FILE"
done<"${BUILDORDER_FILE}"

# Update build status
rm -f "$BUILDSTATUS_FILE"
echo "Finished"
