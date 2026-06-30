#!/usr/bin/bash

clandro_extract_dep_info() {
	( # Do everything in a subshell to avoid variable hell outside the function
	PKG="$1"
	PKG_DIR="$2"

	# set CLANDRO_SUBPKG_PLATFORM_INDEPENDENT to
	# parent package's value and override if
	# needed
	CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED="false"
	CLANDRO_PKG_PLATFORM_INDEPENDENT="false"
	CLANDRO_PKG_REVISION="0"
	source "${PKG_DIR}/build.sh"

	# debian version
	VER_DEBIAN="$CLANDRO_PKG_VERSION"
	if [[ "$CLANDRO_PKG_REVISION" != "0" || "$CLANDRO_PKG_VERSION" != "${CLANDRO_PKG_VERSION/-/}" ]]; then
		VER_DEBIAN+="-$CLANDRO_PKG_REVISION"
	fi

	# pacman version
	VER_PACMAN="${CLANDRO_PKG_VERSION//-/.}"
	if [[ "$VER_PACMAN" =~ [0-9][a-z] ]]; then
		p=${BASH_REMATCH[0]}
		VER_PACMAN=${VER_PACMAN//"$p"/"${p:0:1}.${p:1:1}"}
	fi

	if [[ "$PKG" != "${PKG_DIR##*/}" && "${PKG/-glibc/}" != "${PKG_DIR##*/}" ]]; then
		if [[ "$CLANDRO_INSTALL_DEPS" == "false" || \
				"$CLANDRO_PKG_NO_STATICSPLIT" = "true" || \
				"${PKG/-static/}-static" != "${PKG}" ]]; then
			# Allow commands like `cat ${CLANDRO_PKG_TMPDIR}` to fail inside subpackages buildscripts
			# Usually it does not directly affect target packages
			set +e
			# shellcheck source=/dev/null
			if [[ -f "${PKG_DIR}/${PKG}.subpackage.sh" ]]; then
				source "${PKG_DIR}/${PKG}.subpackage.sh"
			else
				source "${PKG_DIR}/${PKG/-glibc/}.subpackage.sh"
			fi
		fi
	fi
	if [[ "${CLANDRO_SUBPKG_PLATFORM_INDEPENDENT:-$CLANDRO_PKG_PLATFORM_INDEPENDENT}" == "true" ]]; then
		CLANDRO_ARCH=all
	fi

	echo "${CLANDRO_ARCH} ${VER_DEBIAN} ${VER_PACMAN}-${CLANDRO_PKG_REVISION} ${CLANDRO_PKG_ON_DEVICE_BUILD_NOT_SUPPORTED}"
	)
}

# Make script standalone executable as well as sourceable
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	clandro_extract_dep_info "$@"
fi
