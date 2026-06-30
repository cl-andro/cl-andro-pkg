clandro_step_replace_guess_scripts() {
	[ "$CLANDRO_PKG_METAPACKAGE" = "true" ] && return
	[ "$CLANDRO_PKG_NO_REPLACE_GUESS_SCRIPTS" = "true" ] && return

	cd "$CLANDRO_PKG_SRCDIR"
	find . -name config.sub -exec chmod u+w '{}' \; -exec cp "$CLANDRO_SCRIPTDIR/scripts/config.sub" '{}' \;
	find . -name config.guess -exec chmod u+w '{}' \; -exec cp "$CLANDRO_SCRIPTDIR/scripts/config.guess" '{}' \;

	if [ "$CLANDRO_ON_DEVICE_BUILD" = "true" ] && [ "$CLANDRO_PACKAGE_LIBRARY" = "glibc" ]; then
		local list_files=$(grep -s -r -l '^#!.*/bin/' $CLANDRO_PKG_SRCDIR)
		if [ -n "$list_files" ]; then
			sed -i "s|#\!.*/bin/|#\!$CLANDRO_PREFIX_CLASSICAL/bin/|" $list_files
		fi
	fi
}
