CLANDRO_PKG_HOMEPAGE=https://mate-panel.mate-desktop.dev/
CLANDRO_PKG_DESCRIPTION="mate-panel contains the MATE panel, the libmate-panel-applet library and several applets"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_VERSION="1.28.7"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_SRCURL="https://github.com/mate-desktop/mate-panel/releases/download/v$CLANDRO_PKG_VERSION/mate-panel-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=b254791dc05219566cec9a1cec71a3dcc7674e87d94e9628b98157b764bc724c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libice, libmateweather, libsm, libwnck, libx11, libxrandr, mate-desktop, mate-menus, pango, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
