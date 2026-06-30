CLANDRO_SUBPKG_DESCRIPTION="fcitx5 gtk2 immodule"
CLANDRO_SUBPKG_INCLUDE="lib/gtk-2.0"
CLANDRO_SUBPKG_DEPENDS="fcitx5, gtk2, libx11, libxkbcommon, pango"

clandro_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$CLANDRO_PREFIX/bin/sh
	"$CLANDRO_PREFIX/bin/gtk-query-immodules-2.0" \
		> "$CLANDRO_PREFIX/lib/gtk-2.0/2.10.0/immodules.cache"
	EOF
	cat <<- EOF > ./postrm
	#!$CLANDRO_PREFIX/bin/sh
	"$CLANDRO_PREFIX/bin/gtk-query-immodules-2.0" \
		> "$CLANDRO_PREFIX/lib/gtk-2.0/2.10.0/immodules.cache"
	EOF
}
