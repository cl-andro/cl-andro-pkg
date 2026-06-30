clandro_step_handle_host_build() {
	[ "$CLANDRO_PKG_METAPACKAGE" = "true" ] && return
	[ "$CLANDRO_PKG_HOSTBUILD" = "false" ] && return

	cd "$CLANDRO_PKG_SRCDIR"
	local HOST_BUILD_PATCHES=$(find $CLANDRO_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name \*.patch.beforehostbuild | sort)
	for patch in $HOST_BUILD_PATCHES; do
		echo "Applying patch: $(basename $patch)"
		test -f "$patch" && sed "s%\@CLANDRO_PREFIX\@%${CLANDRO_PREFIX}%g" "$patch" | patch --silent -p1
	done

	if [ ! -f "$CLANDRO_HOSTBUILD_MARKER" ]; then
		rm -Rf "$CLANDRO_PKG_HOSTBUILD_DIR"
		mkdir -p "$CLANDRO_PKG_HOSTBUILD_DIR"
		cd "$CLANDRO_PKG_HOSTBUILD_DIR"
		clandro_step_host_build
		touch "$CLANDRO_HOSTBUILD_MARKER"
	fi
}
