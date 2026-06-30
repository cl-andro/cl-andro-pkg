clandro_setup_crystal() {
	local CLANDRO_CRYSTAL_VERSION=1.12.0
	local CLANDRO_CRYSTAL_SHA256=d0c9237e8f0bb8c176545019b2296b65451fb29e2b4c7585986a3f9a4bcc1cb3
	local CLANDRO_CRYSTAL_TARNAME=crystal-${CLANDRO_CRYSTAL_VERSION}-1-linux-x86_64-bundled.tar.gz
	local CLANDRO_CRYSTAL_TARFILE=$CLANDRO_PKG_TMPDIR/crystal-$CLANDRO_CRYSTAL_VERSION.tar.gz
	local CLANDRO_CRYSTAL_FOLDER

	if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
		CLANDRO_CRYSTAL_FOLDER=${CLANDRO_SCRIPTDIR}/build-tools/crystal-${CLANDRO_CRYSTAL_VERSION}
	else
		CLANDRO_CRYSTAL_FOLDER=${CLANDRO_COMMON_CACHEDIR}/crystal-${CLANDRO_CRYSTAL_VERSION}
	fi

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -x "$CLANDRO_CRYSTAL_FOLDER" ]; then
			mkdir -p "$CLANDRO_CRYSTAL_FOLDER"
			clandro_download "https://github.com/crystal-lang/crystal/releases/download/$CLANDRO_CRYSTAL_VERSION/$CLANDRO_CRYSTAL_TARNAME" \
				"$CLANDRO_CRYSTAL_TARFILE" \
				"$CLANDRO_CRYSTAL_SHA256"
			tar xf "$CLANDRO_CRYSTAL_TARFILE" --strip-components=2 -C "$CLANDRO_CRYSTAL_FOLDER"
		fi
		export PATH=$CLANDRO_CRYSTAL_FOLDER/bin:$PATH
	else
		if [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' crystal 2>/dev/null)" != "installed" ]] ||
                   [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q crystal 2>/dev/null)" ]]; then
			echo "Package 'crystal' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install crystal"
			echo
			echo "  pacman -S crystal"
			echo
			exit 1
		fi
	fi
}
