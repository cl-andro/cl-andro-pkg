CLANDRO_SUBPKG_INCLUDE="
bin/gtk-update-icon-cache
share/man/man1/gtk-update-icon-cache.1.gz
share/libalpm/hooks/gtk-update-icon-cache.hook
share/libalpm/scripts/gtk-update-icon-cache
"

CLANDRO_SUBPKG_DEPENDS="gdk-pixbuf, glib"
CLANDRO_SUBPKG_DESCRIPTION="GTK+ icon cache updater"
CLANDRO_SUBPKG_BREAKS="gtk3 (<< 3.24.41)"
CLANDRO_SUBPKG_REPLACES="gtk3 (<< 3.24.41)"

clandro_step_create_subpkg_debscripts() {
	cat <<- EOF > ./triggers
	interest-noawait $CLANDRO_PREFIX/share/icons
	EOF

	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	for i in \$(find "$CLANDRO_PREFIX/share/icons" -type f -iname index.theme); do
		gtk-update-icon-cache --force --quiet \$(dirname "\${i}")
	done
	unset i
	exit 0
	EOF
	if [[ "$CLANDRO_PACKAGE_FORMAT" == "pacman" ]]; then
		echo "post_install" > postupg
	fi
}
