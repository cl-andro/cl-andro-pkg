CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/apps/notifyd/start
CLANDRO_PKG_DESCRIPTION="simple, visually-appealing notification daemon for Xfce"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="0.9.7"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-notifyd/${CLANDRO_PKG_VERSION%.*}/xfce4-notifyd-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=170d18fd5f40cce823ffc7ae3d7e21644007c3f45808ab4835f0401d21b3516a
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk-layer-shell, gtk3, harfbuzz, libcairo, libnotify, libsqlite, libx11, libxfce4ui, libxfce4util, pango, xfce4-panel, xfconf, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export GLIB_MKENUMS=$(command -v glib-mkenums)
	export GLIB_GENMARSHAL=$(command -v glib-genmarshal)
	export GLIB_COMPILE_RESOURCES=$(command -v glib-compile-resources)
	export GDBUS_CODEGEN=$(command -v gdbus-codegen)
}
