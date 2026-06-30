CLANDRO_PKG_HOMEPAGE=https://mate-desktop.mate-desktop.dev/
CLANDRO_PKG_DESCRIPTION="mate-desktop contains the libmate-desktop library, the mate-about program as well as some desktop-wide documents."
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mate-desktop/mate-desktop/releases/download/v$CLANDRO_PKG_VERSION/mate-desktop-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=32bb4b792014b391c1e1b8ae9c18a82b4d447650984b4cba7d28e95564964aa2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, dconf, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libx11, libxrandr, pango, startup-notification, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, iso-codes"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
