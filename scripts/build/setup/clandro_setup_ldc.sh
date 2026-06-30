# shellcheck shell=bash disable=SC2115,SC2155
clandro_setup_ldc_cross_config() {
	local WIDER_TRIPLE="${CLANDRO_LDC_TRIPLE/--/-.*-}"
	# arm target is armv7a-unknown-linux-android
	if [[ "$CLANDRO_ARCH" = "arm" ]]; then
		WIDER_TRIPLE="${WIDER_TRIPLE/androideabi/android.*}"
	fi

	local LDFLAGS_LINES=""
	local NEWLINE=$'\n'
	local OLDIFS=$IFS
	for paramater in $LDFLAGS; do
		[[ $paramater != -Wl,* ]] && continue
		flags=${paramater#-Wl,} # Remove -Wl,
		local IFS=,
		for flag in $flags; do
			LDFLAGS_LINES="${LDFLAGS_LINES}${NEWLINE}        \"-L${flag}\","
		done
		IFS=$OLDIFS
	done

	cp "${1}.orig" "$1"
	cat <<- EOF >> "$1"
	"${WIDER_TRIPLE}":
	{
	    switches = [
	        "-defaultlib=phobos2-ldc,druntime-ldc",
	        "-gcc=${CC}",
	        "-Xcc=-B",
	        "-Xcc=%%ldcbinarypath%%",
	        "-L-rpath-link=${CLANDRO_PREFIX}/lib",${LDFLAGS_LINES}
	    ];
	    lib-dirs = [
	        "${CLANDRO_PREFIX}/lib",
	    ];
	    rpath = "${CLANDRO_PREFIX}/lib";
	};
	EOF
	ln -sf "${CLANDRO_PREFIX}/opt/binutils/cross/bin/${CLANDRO_HOST_PLATFORM}-ld" \
		"${CLANDRO_BUILDLDC_FOLDER}/bin/ld.bfd"
}

clandro_setup_ldc() {
	CLANDRO_LDC_TRIPLE=${CLANDRO_HOST_PLATFORM/-/--}
	if [[ "$CLANDRO_ARCH" = "arm" ]]; then
		CLANDRO_LDC_TRIPLE=${CLANDRO_LDC_TRIPLE/arm-/armv7a-}
	fi
	if [[ "$CLANDRO_ON_DEVICE_BUILD" = "false" ]]; then
		local CLANDRO_LDC_VERSION=$(. "${CLANDRO_SCRIPTDIR}/packages/ldc/build.sh"; \
			echo "${CLANDRO_PKG_VERSION}")
		local CLANDRO_LDC_PLATFORM=linux-x86_64

		test -f "${CLANDRO_PREFIX}/lib/libdruntime-ldc.a" ||
			clandro_error_exit "Package 'ldc' is not installed. " \
				"It is required by LDC cross-compiler. " \
				"You should specify it in 'CLANDRO_PKG_BUILD_DEPENDS'."
		test -f "${CLANDRO_PREFIX}/opt/binutils/cross/bin/${CLANDRO_HOST_PLATFORM}-ld" ||
			clandro_error_exit "Package 'binutils-cross' is not installed. " \
				"It is required by LDC cross-compiler." \
				"You should specify it in 'CLANDRO_PKG_BUILD_DEPENDS'."

		local CLANDRO_BUILDLDC_FOLDER
		if [[ "${CLANDRO_PACKAGES_OFFLINE-false}" = "true" ]]; then
			CLANDRO_BUILDLDC_FOLDER=${CLANDRO_SCRIPTDIR}/build-tools/ldc2-${CLANDRO_LDC_VERSION}
		else
			CLANDRO_BUILDLDC_FOLDER=${CLANDRO_COMMON_CACHEDIR}/ldc2-${CLANDRO_LDC_VERSION}
		fi
		local CLANDRO_BUILDLDC_NAME=ldc2-${CLANDRO_LDC_VERSION}-${CLANDRO_LDC_PLATFORM}
		local CLANDRO_BUILDLDC_CONF=${CLANDRO_BUILDLDC_FOLDER}/etc/ldc2.conf

		export PATH=${CLANDRO_BUILDLDC_FOLDER}/bin:${PATH}

		if [[ -d "$CLANDRO_BUILDLDC_FOLDER" ]]; then
			ln -sf "${CLANDRO_PREFIX}/opt/binutils/cross/bin/${CLANDRO_HOST_PLATFORM}-ld" \
				"${CLANDRO_BUILDLDC_FOLDER}/bin/ld.bfd"
			clandro_setup_ldc_cross_config "$CLANDRO_BUILDLDC_CONF"
			return
		fi

		local CLANDRO_BUILDLDC_TAR=$CLANDRO_COMMON_CACHEDIR/${CLANDRO_BUILDLDC_NAME}.tar.xz
		rm -Rf "${CLANDRO_COMMON_CACHEDIR}/$CLANDRO_BUILDLDC_NAME" \
			"$CLANDRO_BUILDLDC_FOLDER"
		clandro_download "https://github.com/ldc-developers/ldc/releases/download/v${CLANDRO_LDC_VERSION}/ldc2-${CLANDRO_LDC_VERSION}.sha256sums.txt" \
			"${CLANDRO_BUILDLDC_TAR}.chksum" \
			SKIP_CHECKSUM
		local CLANDRO_LDC_SHA256=$(grep ${CLANDRO_LDC_PLATFORM} \
			"${CLANDRO_BUILDLDC_TAR}.chksum" | awk -F " " '{print $1}')
		clandro_download "https://github.com/ldc-developers/ldc/releases/download/v${CLANDRO_LDC_VERSION}/ldc2-${CLANDRO_LDC_VERSION}-${CLANDRO_LDC_PLATFORM}.tar.xz" \
			"$CLANDRO_BUILDLDC_TAR" \
			"${CLANDRO_LDC_SHA256}"

		( cd "$CLANDRO_COMMON_CACHEDIR"; tar xJf "$CLANDRO_BUILDLDC_TAR"; \
			mv "$CLANDRO_BUILDLDC_NAME" "$CLANDRO_BUILDLDC_FOLDER"; \
			rm "$CLANDRO_BUILDLDC_TAR" "${CLANDRO_BUILDLDC_TAR}.chksum") || exit 1

		cp "$CLANDRO_BUILDLDC_CONF" "${CLANDRO_BUILDLDC_CONF}.orig"
		clandro_setup_ldc_cross_config "$CLANDRO_BUILDLDC_CONF"
	else
		if [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "apt" && "$(dpkg-query -W -f '${db:Status-Status}\n' ldc 2>/dev/null)" != "installed" ]] ||
		   [[ "$CLANDRO_APP_PACKAGE_MANAGER" = "pacman" && ! "$(pacman -Q ldc 2>/dev/null)" ]]; then
			echo "Package 'ldc' is not installed."
			echo "You can install it with"
			echo
			echo "  pkg install ldc"
			echo
			echo "  pacman -S ldc"
			echo
			exit 1
		fi
	fi
}
