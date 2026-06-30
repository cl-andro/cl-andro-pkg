clandro_setup_cargo_c() {
	local CLANDRO_CARGO_C_VERSION=0.10.15
	local CLANDRO_CARGO_C_SHA256=066ff231fffa7c5f22ede897dd968110eddee6f16eff6eaf9415231efce57dbb
	local CLANDRO_CARGO_C_TARNAME=cargo-c-x86_64-unknown-linux-musl.tar.gz
	local CLANDRO_CARGO_C_TARFILE=$CLANDRO_PKG_TMPDIR/$CLANDRO_CARGO_C_TARNAME
	local CLANDRO_CARGO_C_FOLDER

	if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
		CLANDRO_CARGO_C_FOLDER=$CLANDRO_SCRIPTDIR/build-tools/cargo-c-$CLANDRO_CARGO_C_VERSION
	else
		CLANDRO_CARGO_C_FOLDER=$CLANDRO_COMMON_CACHEDIR/cargo-c-$CLANDRO_CARGO_C_VERSION
	fi

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
		if [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' cargo-c 2>/dev/null)" != "installed" ]] ||
			[[ "$CLANDRO_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q cargo-c 2>/dev/null)" ]]; then
			echo "Package 'cargo-c' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install cargo-c"
			echo
			echo "  pacman -S cargo-c"
			echo
			exit 1
		fi
		return
	fi

	if [ ! -d "$CLANDRO_CARGO_C_FOLDER" ]; then
		clandro_download https://github.com/lu-zero/cargo-c/releases/download/v$CLANDRO_CARGO_C_VERSION/$CLANDRO_CARGO_C_TARNAME \
			"$CLANDRO_CARGO_C_TARFILE" \
			"$CLANDRO_CARGO_C_SHA256"
		rm -Rf "$CLANDRO_CARGO_C_FOLDER"
		mkdir -p "$CLANDRO_CARGO_C_FOLDER"
		tar xf "$CLANDRO_CARGO_C_TARFILE" -C "$CLANDRO_CARGO_C_FOLDER"
	fi

	export PATH=$CLANDRO_CARGO_C_FOLDER:$PATH
}
