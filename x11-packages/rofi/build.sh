CLANDRO_PKG_HOMEPAGE=https://davatorium.github.io/rofi/
CLANDRO_PKG_DESCRIPTION="A window switcher, application launcher and dmenu replacement"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.0.0"
CLANDRO_PKG_SRCURL="https://github.com/davatorium/rofi/releases/download/$CLANDRO_PKG_VERSION/rofi-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=6a55ee27f189ef9a1435cea329b146805b5dc830d8abc7a08c50a971521a8d8d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, libandroid-glob, libcairo, libwayland, libxcb, libxkbcommon, pango, startup-notification, xcb-util, xcb-util-cursor, xcb-util-keysyms, xcb-util-wm"

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper

	# ld.lld: error: undefined symbol: glob, globfree
	LDFLAGS+=" -landroid-glob"

	sed \
	"s|@CLANDRO_PKG_VERSION@|${CLANDRO_PKG_VERSION}|g" \
	"$CLANDRO_PKG_BUILDER_DIR"/nkutils-git-version.h.in > "$CLANDRO_PKG_SRCDIR"/subprojects/libnkutils/core/include/nkutils-git-version.h
}
