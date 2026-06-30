CLANDRO_SUBPKG_DESCRIPTION="fcitx5 gtk3 immodule"
CLANDRO_SUBPKG_INCLUDE="lib/gtk-3.0"
CLANDRO_SUBPKG_DEPENDS="fcitx5, gdk-pixbuf, gtk3, libc++, libcairo, libx11, libxkbcommon, pango"

clandro_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	"$CLANDRO_PREFIX/bin/gtk-query-immodules-3.0" \
		> "$CLANDRO_PREFIX/lib/gtk-3.0/3.0.0/immodules.cache"
	EOF
	cat <<- EOF > ./postrm
	#!$CLANDRO_PREFIX/bin/sh
	"$CLANDRO_PREFIX/bin/gtk-query-immodules-3.0" \
		> "$CLANDRO_PREFIX/lib/gtk-3.0/3.0.0/immodules.cache"
	EOF
}
