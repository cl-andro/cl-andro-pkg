clandro_step_make() {
	[ "$CLANDRO_PKG_METAPACKAGE" = "true" ] && return

	local QUIET_BUILD=
	if [ "$CLANDRO_QUIET_BUILD" = true ]; then
		QUIET_BUILD="-s"
	fi

	if test -f build.ninja; then
		ninja -j $CLANDRO_PKG_MAKE_PROCESSES
	elif ls ./*.cabal &>/dev/null || ls ./cabal.project &>/dev/null; then
		cabal --config="$CLANDRO_CABAL_CONFIG" build
	elif ls ./*akefile &>/dev/null || [ ! -z "$CLANDRO_PKG_EXTRA_MAKE_ARGS" ]; then
		if [ -z "$CLANDRO_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j $CLANDRO_PKG_MAKE_PROCESSES $QUIET_BUILD
		else
			make -j $CLANDRO_PKG_MAKE_PROCESSES $QUIET_BUILD ${CLANDRO_PKG_EXTRA_MAKE_ARGS}
		fi
	elif test -f dub.json; then
		clandro_setup_ldc
		dub build \
			-b release \
			--compiler=ldc2 \
			--arch "$CLANDRO_LDC_TRIPLE"\
			${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS:+ $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS}
	fi
}

clandro_step_make_multilib() {
	clandro_step_make
}
