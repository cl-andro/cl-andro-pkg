#!/bin/bash

set -e -u

# This script is in '$CLANDRO_SCRIPTDIR/scripts/bin/'.
CLANDRO_SCRIPTDIR=$(cd "$(realpath "$(dirname "$0")")"; cd ../..; pwd)
DRY_RUN_SCRIPT_NAME=$(basename "$0")
BUILDSCRIPT_NAME="build-package.sh"
CLANDRO_ARCH="aarch64"
CLANDRO_DEBUG_BUILD="false"
CLANDRO_PACKAGES_DIRECTORIES="
packages
root-packages
x11-packages
"

# Please keep synchronized with the logic of lines 468-547 of 'build-package.sh'.
declare -a PACKAGE_LIST=()
while (($# >= 1)); do
	case "$1" in
		*"/$BUILDSCRIPT_NAME") ;;
		-a)
			if [ $# -lt 2 ]; then
				echo "$DRY_RUN_SCRIPT_NAME: Option '-a' requires an argument"
				exit 1
			fi
			shift 1
			if [ -z "$1" ]; then
				echo "$DRY_RUN_SCRIPT_NAME: Argument to '-a' should not be empty."
				exit 1
			fi
			CLANDRO_ARCH="$1"
			;;
		-d) CLANDRO_DEBUG_BUILD="true" ;;
		-*) ;;
		*) PACKAGE_LIST+=("$1") ;;
	esac
	shift 1
done

# Please keep synchronized with the logic of lines 592-656 of 'build-package.sh'.
for ((i=0; i<${#PACKAGE_LIST[@]}; i++)); do
	CLANDRO_PKG_NAME=$(basename "${PACKAGE_LIST[i]}")
	CLANDRO_PKG_BUILDER_DIR=
	for package_directory in $CLANDRO_PACKAGES_DIRECTORIES; do
		if [ -d "${CLANDRO_SCRIPTDIR}/${package_directory}/${CLANDRO_PKG_NAME}" ]; then
			CLANDRO_PKG_BUILDER_DIR="${CLANDRO_SCRIPTDIR}/$package_directory/$CLANDRO_PKG_NAME"
			break
		fi
	done
	if [ -z "${CLANDRO_PKG_BUILDER_DIR}" ]; then
		echo "$DRY_RUN_SCRIPT_NAME: No package $CLANDRO_PKG_NAME found in any of the enabled repositories. Are you trying to set up a custom repository?"
		exit 1
	fi
	CLANDRO_PKG_BUILDER_SCRIPT="$CLANDRO_PKG_BUILDER_DIR/build.sh"

	# Please keep synchronized with the logic of lines 2-50 of 'scripts/build/clandro_step_start_build.sh'.
	if [ "${CLANDRO_ARCH}" != "all" ] && \
		grep -qE "^CLANDRO_PKG_EXCLUDED_ARCHES=.*${CLANDRO_ARCH}" "$CLANDRO_PKG_BUILDER_SCRIPT"; then
		echo "$DRY_RUN_SCRIPT_NAME: Skipping building $CLANDRO_PKG_NAME for arch $CLANDRO_ARCH"
		continue
	fi

	if [ "${CLANDRO_DEBUG_BUILD}" = "true" ] && \
		grep -qE "^CLANDRO_PKG_HAS_DEBUG=.*false" "$CLANDRO_PKG_BUILDER_SCRIPT"; then
		echo "$DRY_RUN_SCRIPT_NAME: Skipping building debug build for $CLANDRO_PKG_NAME"
		continue
	fi

	echo "$DRY_RUN_SCRIPT_NAME: Ending dry run simulation ($BUILDSCRIPT_NAME would have continued building $CLANDRO_PKG_NAME)"
	exit 0
done

if [ ${#PACKAGE_LIST[@]} -gt 0 ]; then
	# At least one package name was parsed, but none of them reached "exit 0",
	# so exit with return value 85 (EX_C__NOOP) to indicate that no packages would have been built.
	echo "$DRY_RUN_SCRIPT_NAME: Ending dry run simulation ($BUILDSCRIPT_NAME would not have built any packages)"
	exit 85 # EX_C__NOOP
fi

# If this point is reached, assume that a combination of arguments
# that is either invalid or is not implemented in this script
# has been used, and that the real 'build-package.sh'
# needs to be run so that its own parser can interpret the arguments
# and display the appropriate message.
echo "$DRY_RUN_SCRIPT_NAME: Ending dry run simulation (unknown arguments, pass to the real $BUILDSCRIPT_NAME for more information)"
exit 0
