clandro_setup_capnp() {
	local _CAPNP_BUILD_SH="$CLANDRO_SCRIPTDIR/packages/capnproto/build.sh"
	local _CAPNP_VERSION=$(bash -c ". $_CAPNP_BUILD_SH; echo \${CLANDRO_PKG_VERSION#*:}")
	local _CAPNP_SRCURL=$(bash -c ". $_CAPNP_BUILD_SH; echo \${CLANDRO_PKG_SRCURL}")
	local _CAPNP_SHA256=$(bash -c ". $_CAPNP_BUILD_SH; echo \${CLANDRO_PKG_SHA256}")
	local _CAPNP_SRCARCHIVE="${CLANDRO_PKG_TMPDIR}/capnp-${_CAPNP_VERSION}.tar.gz"
	local _CAPNP_SRCDIR="${CLANDRO_PKG_TMPDIR}/capnp-${_CAPNP_VERSION}"
	local _CAPNP_FOLDER

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		if ([ ! -e "$CLANDRO_BUILT_PACKAGES_DIRECTORY/capnproto" ] ||
			[ "$(cat "$CLANDRO_BUILT_PACKAGES_DIRECTORY/capnproto")" != "$_CAPNP_VERSION" ]) &&
			([[ "$CLANDRO_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' capnproto 2>/dev/null)" != "installed" ]] ||
			[[ "$CLANDRO_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q capnproto 2>/dev/null)" ]]); then
			echo "Package 'capnproto' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install capnproto"
			echo
			echo "  pacman -S capnproto"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh capnproto"
			echo
			exit 1
		fi
		return
	fi

	if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
		_CAPNP_FOLDER="${CLANDRO_SCRIPTDIR}/build-tools/capnp-${_CAPNP_VERSION}"
	else
		_CAPNP_FOLDER="${CLANDRO_COMMON_CACHEDIR}/capnp-${_CAPNP_VERSION}"
	fi

	if [ ! -d "$_CAPNP_FOLDER" ]; then
	(
		clandro_download "$_CAPNP_SRCURL" "$_CAPNP_SRCARCHIVE" "$_CAPNP_SHA256"

		rm -Rf "$_CAPNP_SRCDIR"
		mkdir -p "$_CAPNP_SRCDIR/build"
		tar -xf "$_CAPNP_SRCARCHIVE" --strip-components=1 -C "$_CAPNP_SRCDIR"
		clandro_setup_cmake
		clandro_setup_ninja
		unset AR CC CFLAGS CPPFLAGS CXX CXXFLAGS LD LDFLAGS PKG_CONFIG PKG_CONFIG_LIBDIR PKGCONFIG STRIP
		cmake \
			-S "$_CAPNP_SRCDIR" \
			-B "$_CAPNP_SRCDIR/build" \
			-GNinja \
			-DPKG_CONFIG_EXECUTABLE=/usr/bin/pkg-config \
			-DCMAKE_INSTALL_PREFIX="$_CAPNP_FOLDER"
		ninja -C "$_CAPNP_SRCDIR/build" -j "$CLANDRO_PKG_MAKE_PROCESSES"
		ninja -C "$_CAPNP_SRCDIR/build" install
	)
	fi

	export PATH="$_CAPNP_FOLDER/bin:$PATH"
}
