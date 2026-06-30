clandro_setup_swift() {
	local SWIFT_TRIPLE=${CLANDRO_HOST_PLATFORM/-/-unknown-}$CLANDRO_PKG_API_LEVEL
	export SWIFT_TARGET_TRIPLE=${SWIFT_TRIPLE/arm-/armv7-}

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]; then
		local CLANDRO_SWIFT_VERSION=$(. $CLANDRO_SCRIPTDIR/packages/swift/build.sh; echo $CLANDRO_PKG_VERSION)
		local SWIFT_RELEASE=$(. $CLANDRO_SCRIPTDIR/packages/swift/build.sh; echo $SWIFT_RELEASE)
		local SWIFT_BIN="swift-$CLANDRO_SWIFT_VERSION-$SWIFT_RELEASE-ubuntu24.04"
		local SWIFT_FOLDER

		if [ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]; then
			SWIFT_FOLDER=${CLANDRO_SCRIPTDIR}/build-tools/${SWIFT_BIN}
		else
			SWIFT_FOLDER=${CLANDRO_COMMON_CACHEDIR}/${SWIFT_BIN}
		fi

		if [ ! -d "$SWIFT_FOLDER" ]; then
			local SWIFT_TAR=$CLANDRO_PKG_TMPDIR/${SWIFT_BIN}.tar.gz
			clandro_download \
				https://download.swift.org/swift-$CLANDRO_SWIFT_VERSION-release/ubuntu2404/swift-$CLANDRO_SWIFT_VERSION-$SWIFT_RELEASE/$SWIFT_BIN.tar.gz \
				$SWIFT_TAR \
				4022cb64faf7e2681c19f9b62a22fb7d9055db6194d9e4a4bef9107b6ce10946

			(cd $CLANDRO_PKG_TMPDIR ; tar xf $SWIFT_TAR ; mv $SWIFT_BIN $SWIFT_FOLDER; rm $SWIFT_TAR)
		fi
		export SWIFT_BINDIR="$SWIFT_FOLDER/usr/bin"
		export SWIFT_CROSSCOMPILE_CONFIG="$SWIFT_FOLDER/usr/android-$CLANDRO_ARCH.json"
		if [ ! -z ${CLANDRO_STANDALONE_TOOLCHAIN+x} ]; then
			local MULTILIB_DIR="$CLANDRO_ARCH-linux-android"
			test $CLANDRO_ARCH == 'arm' && MULTILIB_DIR+="eabi"
			cat <<- EOF > $SWIFT_CROSSCOMPILE_CONFIG
			{ "version": 1,
			"target": "${SWIFT_TARGET_TRIPLE}",
			"toolchain-bin-dir": "${SWIFT_BINDIR}",
			"sdk": "${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot",
			"extra-cc-flags": [ "-fPIC" ],
			"extra-swiftc-flags": [ "-resource-dir", "${CLANDRO_PREFIX}/lib/swift",
			   "-Xcc", "-I${CLANDRO_PREFIX}/include",
			   "-L${CLANDRO_PREFIX}/opt/ndk-multilib/$MULTILIB_DIR/lib", "-L${CLANDRO_PREFIX}/lib",
			   "-tools-directory", "${CLANDRO_STANDALONE_TOOLCHAIN}/bin", ],
			"extra-cpp-flags": [ "-lstdc++" ] }
			EOF
		fi
	else
		if [[ "${CLANDRO_APP_PACKAGE_MANAGER}" == "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' swift 2>/dev/null)" != "installed" ]] ||
		   [[ "${CLANDRO_APP_PACKAGE_MANAGER}" == "pacman" && ! "$(pacman -Q swift 2>/dev/null)" ]]; then
			echo "Package 'swift' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install swift"
			echo
			echo "  pacman -S swift"
			echo
			echo "or build it from source with"
			echo
			echo "  ./build-package.sh swift"
			echo
			exit 1
		fi
		export SWIFT_BINDIR="$CLANDRO_PREFIX/bin"
	fi
}
