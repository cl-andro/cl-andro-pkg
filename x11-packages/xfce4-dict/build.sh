CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/apps/xfce4-dict/start
CLANDRO_PKG_DESCRIPTION="Dictionary for XFCE desktop"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.9"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-dict/${CLANDRO_PKG_VERSION%.*}/xfce4-dict-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=f1a81baad1e60496aeffc8f8ef1be6413c732b09e250d52d062d293ade001a8c
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libx11, libxfce4ui, libxfce4util, pango, xfce4-panel, zlib"
CLANDRO_PKG_SUGGESTS="aspell"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_glib_cross_pkg_config_wrapper
}
