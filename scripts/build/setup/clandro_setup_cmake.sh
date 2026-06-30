clandro_setup_cmake() {
	local CLANDRO_CMAKE_VERSION=4.3.2
	local CLANDRO_CMAKE_SHA256=791ae3604841ca03cb3889a3ad89165346e4b180ae3448efd4b0caa9ef46d245
	local CLANDRO_CMAKE_MAJORVERSION="${CLANDRO_CMAKE_VERSION%.*}"
	local CLANDRO_CMAKE_TARNAME="cmake-${CLANDRO_CMAKE_VERSION}-linux-x86_64.tar.gz"
	local CLANDRO_CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v${CLANDRO_CMAKE_VERSION}/${CLANDRO_CMAKE_TARNAME}"
	local CLANDRO_CMAKE_TARFILE="${CLANDRO_PKG_TMPDIR}/${CLANDRO_CMAKE_TARNAME}"
	local CLANDRO_CMAKE_FOLDER="${CLANDRO_COMMON_CACHEDIR}/cmake-${CLANDRO_CMAKE_VERSION}"
	if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
		CLANDRO_CMAKE_FOLDER="${CLANDRO_SCRIPTDIR}/build-tools/cmake-${CLANDRO_CMAKE_VERSION}"
	fi

	if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
		local CLANDRO_CMAKE_NAME="cmake"
	elif [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
		local CLANDRO_CMAKE_NAME="cmake-glibc"
	fi

	export CMAKE_INSTALL_ALWAYS=1

	if [ "${CLANDRO_ON_DEVICE_BUILD}" = "true" ]; then
		if [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' $CLANDRO_CMAKE_NAME 2>/dev/null)" != "installed" ]] ||
			[[ "$CLANDRO_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q $CLANDRO_CMAKE_NAME 2>/dev/null)" ]]; then
			echo "Package '$CLANDRO_CMAKE_NAME' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install $CLANDRO_CMAKE_NAME"
			echo
			echo "  pacman -S $CLANDRO_CMAKE_NAME"
			echo
			exit 1
		fi
		return
	fi

	if [ ! -d "${CLANDRO_CMAKE_FOLDER}" ]; then
		clandro_download "${CLANDRO_CMAKE_URL}" \
			"${CLANDRO_CMAKE_TARFILE}" \
			"${CLANDRO_CMAKE_SHA256}"
		rm -Rf "${CLANDRO_PKG_TMPDIR}/cmake-${CLANDRO_CMAKE_VERSION}-linux-x86_64"
		tar xf "${CLANDRO_CMAKE_TARFILE}" -C "${CLANDRO_PKG_TMPDIR}"
		mv "${CLANDRO_PKG_TMPDIR}/cmake-${CLANDRO_CMAKE_VERSION}-linux-x86_64" \
			"${CLANDRO_CMAKE_FOLDER}"
	fi

	export PATH="${CLANDRO_CMAKE_FOLDER}/bin:${PATH}"
}
