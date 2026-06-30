clandro_step_setup_toolchain() {
	if [ "$CLANDRO_PACKAGE_LIBRARY" = "bionic" ]; then
		CLANDRO_STANDALONE_TOOLCHAIN="$CLANDRO_COMMON_CACHEDIR/android-r${CLANDRO_NDK_VERSION}-api-${CLANDRO_PKG_API_LEVEL}"
		[ "$CLANDRO_PKG_METAPACKAGE" = "true" ] && return

		# Bump CLANDRO_STANDALONE_TOOLCHAIN if a change is made in
		# toolchain setup to ensure that everyone gets an updated
		# toolchain
		if [ "${CLANDRO_NDK_VERSION}" = "29" ]; then
			CLANDRO_STANDALONE_TOOLCHAIN+="-v4"
			clandro_setup_toolchain_29
		elif [ "${CLANDRO_NDK_VERSION}" = 23c ]; then
			CLANDRO_STANDALONE_TOOLCHAIN+="-v11"
			clandro_setup_toolchain_23c
		else
			clandro_error_exit "We do not have a setup_toolchain function for NDK version $CLANDRO_NDK_VERSION"
		fi
	elif [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
		if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ]; then
			CLANDRO_STANDALONE_TOOLCHAIN="$CLANDRO_PREFIX"
		else
			CLANDRO_STANDALONE_TOOLCHAIN="${CGCT_DIR}/${CLANDRO_ARCH}"
		fi
		clandro_setup_toolchain_gnu
	fi
}

clandro_step_setup_multilib_environment() {
	clandro_conf_multilib_vars
	if [ "$CLANDRO_PKG_BUILD_ONLY_MULTILIB" = "false" ]; then
		CLANDRO_PKG_BUILDDIR="$CLANDRO_PKG_MULTILIB_BUILDDIR"
	fi
	clandro_step_setup_arch_variables
	clandro_step_setup_pkg_config_libdir
	clandro_step_setup_toolchain
	cd $CLANDRO_PKG_BUILDDIR
}
