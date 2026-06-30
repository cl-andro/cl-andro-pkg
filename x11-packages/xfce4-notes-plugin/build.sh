CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-notes-plugin/start
CLANDRO_PKG_DESCRIPTION="Notes application for the Xfce4 desktop"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="1.12.0"
CLANDRO_PKG_SRCURL="https://archive.xfce.org/src/panel-plugins/xfce4-notes-plugin/${CLANDRO_PKG_VERSION%.*}/xfce4-notes-plugin-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=cf4cc8f2e9785b7032aef6a74f316b8d7945457982295f8465a872b75da46a2a
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, gtksourceview4, harfbuzz, libcairo, libxfce4ui, libxfce4util, pango, xfce4-panel, xfconf, zlib"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_gir
}
