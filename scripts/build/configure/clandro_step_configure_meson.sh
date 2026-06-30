clandro_step_configure_meson() {
	clandro_setup_meson

	local _meson_buildtype="minsize"
	local _meson_stripflag="--strip"
	if [ "$CLANDRO_DEBUG_BUILD" = "true" ]; then
		_meson_buildtype="debug"
		_meson_stripflag=
	fi

	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $CLANDRO_MESON \
		setup \
		$CLANDRO_PKG_SRCDIR \
		$CLANDRO_PKG_BUILDDIR \
		--$(test "${CLANDRO_PKG_MESON_NATIVE}" = "true" && echo "native-file" || echo "cross-file") $CLANDRO_MESON_CROSSFILE \
		--prefix $CLANDRO_PREFIX \
		--libdir $CLANDRO__PREFIX__LIB_SUBDIR \
		--includedir $CLANDRO__PREFIX__INCLUDE_SUBDIR \
		--buildtype ${_meson_buildtype} \
		${_meson_stripflag} \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS \
		|| (clandro_step_configure_meson_failure_hook && false)
}

clandro_step_configure_meson_failure_hook() {
	false
}
