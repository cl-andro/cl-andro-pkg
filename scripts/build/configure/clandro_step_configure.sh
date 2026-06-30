clandro_step_configure() {
	[ "$CLANDRO_PKG_METAPACKAGE" = "true" ] && return

	# This check should be above autotools check as haskell package too makes use of configure scripts which
	# should be executed by its own build system.
	if ls "${CLANDRO_PKG_SRCDIR}"/*.cabal &>/dev/null || ls "${CLANDRO_PKG_SRCDIR}"/cabal.project &>/dev/null; then
		[ "$CLANDRO_CONTINUE_BUILD" == "true" ] && return
		clandro_step_configure_cabal
	elif [ "$CLANDRO_PKG_FORCE_CMAKE" = "false" ] && [ -f "$CLANDRO_PKG_SRCDIR/configure" ]; then
		if [ "$CLANDRO_CONTINUE_BUILD" == "true" ]; then
			return
		fi
		clandro_step_configure_autotools
	elif [ "$CLANDRO_PKG_FORCE_CMAKE" = "true" ] || [ -f "$CLANDRO_PKG_SRCDIR/CMakeLists.txt" ]; then
		clandro_setup_cmake
		if [ "$CLANDRO_PKG_CMAKE_BUILD" = Ninja ]; then
			clandro_setup_ninja
		fi

		# Some packages, for example swift, uses cmake
		# internally, but cannot be configured with our
		# clandro_step_configure_cmake function (CMakeLists.txt
		# is not in src dir)
		if [ -f "$CLANDRO_PKG_SRCDIR/CMakeLists.txt" ] &&
			[ "$CLANDRO_CONTINUE_BUILD" == "false" ]; then
			clandro_step_configure_cmake
		fi
	elif [ -f "$CLANDRO_PKG_SRCDIR/meson.build" ]; then
		if [ "$CLANDRO_CONTINUE_BUILD" == "true" ]; then
			return
		fi
		clandro_step_configure_meson
	fi
}

clandro_step_configure_multilib() {
	clandro_step_configure
}
