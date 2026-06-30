# Utility function for golang-using packages to setup a go toolchain.
clandro_setup_golang() {
	export GOPATH="${CLANDRO_COMMON_CACHEDIR}/go-path" GOCACHE="${CLANDRO_COMMON_CACHEDIR}/go-build"
	mkdir -p "$GOPATH" "$GOCACHE"
	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		local CLANDRO_GO_VERSION=go1.26.2
		local CLANDRO_GO_SHA256=990e6b4bbba816dc3ee129eaeaf4b42f17c2800b88a2166c265ac1a200262282
		local CLANDRO_GO_PLATFORM=linux-amd64

		local CLANDRO_BUILDGO_FOLDER
		if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
			CLANDRO_BUILDGO_FOLDER=${CLANDRO_SCRIPTDIR}/build-tools/${CLANDRO_GO_VERSION}
		else
			CLANDRO_BUILDGO_FOLDER=${CLANDRO_COMMON_CACHEDIR}/${CLANDRO_GO_VERSION}
		fi

		CLANDRO_BUILDGO_FOLDER+="-r1"

		export GOROOT=$CLANDRO_BUILDGO_FOLDER
		export PATH=${GOROOT}/bin:${PATH}

		if [ -d "$CLANDRO_BUILDGO_FOLDER" ]; then return; fi

		local CLANDRO_BUILDGO_TAR=$CLANDRO_COMMON_CACHEDIR/${CLANDRO_GO_VERSION}.${CLANDRO_GO_PLATFORM}.tar.gz
		rm -Rf "$CLANDRO_COMMON_CACHEDIR/go" "$CLANDRO_BUILDGO_FOLDER"
		clandro_download https://go.dev/dl/${CLANDRO_GO_VERSION}.${CLANDRO_GO_PLATFORM}.tar.gz \
			"$CLANDRO_BUILDGO_TAR" \
			"$CLANDRO_GO_SHA256"

		(
			cd "$CLANDRO_COMMON_CACHEDIR"
			tar xf "$CLANDRO_BUILDGO_TAR"
			mv go "$CLANDRO_BUILDGO_FOLDER"
			rm "$CLANDRO_BUILDGO_TAR"
		)

		(
			cd "$CLANDRO_BUILDGO_FOLDER"
			. "${CLANDRO_SCRIPTDIR}/packages/golang/patch-script/fix-hardcoded-etc-resolv-conf.sh"
			. "${CLANDRO_SCRIPTDIR}/packages/golang/patch-script/remove-pidfd.sh"
			. "${CLANDRO_SCRIPTDIR}/packages/golang/patch-script/remove-futex_time64.sh"
		)
	else
		if [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' golang 2>/dev/null)" != "installed" ]] ||
		[[ "$CLANDRO_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q golang 2>/dev/null)" ]]; then
			echo "Package 'golang' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install golang"
			echo
			echo "  pacman -S golang"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh golang"
			echo
			exit 1
		fi

		export GOROOT="$CLANDRO__PREFIX__LIB_DIR/go"
	fi
}
