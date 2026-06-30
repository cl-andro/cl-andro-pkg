CLANDRO_PKG_HOMEPAGE=https://gitlab.com/vala-panel-project/vala-panel-appmenu
CLANDRO_PKG_DESCRIPTION="Global Menu for Vala Panel (metapackage)"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="25.04"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://gitlab.com/vala-panel-project/vala-panel-appmenu/-/archive/${CLANDRO_PKG_VERSION}/vala-panel-appmenu-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=ff270de372c41f18f64e8788629dd4cc9f116a89ee8947e3fc2657b19182e2dc
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, gtk3, valac"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dwm_backend=wnck
-Dvalapanel=disabled
-Dxfce=enabled
-Dmate=enabled
-Dbudgie=disabled
-Dregistrar=disabled
-Dappmenu-gtk-module=enabled
-Djayatana=disabled
-Dappmenu-gtk-module:gtk=3
"

clandro_step_pre_configure() {
	clandro_setup_gir

	CPPFLAGS+=" -Dulong=u_long"
	LDFLAGS+=" -lX11"
	clandro_setup_glib_cross_pkg_config_wrapper

	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		# adjust valac wrapper created by the cross-compilation mode
		# of clandro_setup_gir, to avoid a specific error
		# that only happens to vala-panel-appmenu and
		# only happens when cross-compiling it
		# error: The name `Property' does not exist in the context of `Xfconf' (libxfconf-0)
		rm -f "$CLANDRO_PREFIX/lib/pkgconfig/appmenu-glib-translator.pc"
		mkdir -p "$CLANDRO_PKG_TMPDIR/custom-bin"
		cp "$(command -v valac)" "$CLANDRO_PKG_TMPDIR/custom-bin"
		sed -i "s|--vapidir=\"$CLANDRO_PREFIX/share/vala/vapi\"||g" \
			"$CLANDRO_PKG_TMPDIR/custom-bin/valac"
		export PATH="$CLANDRO_PKG_TMPDIR/custom-bin:$PATH"
	fi
}
