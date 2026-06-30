CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/thunar/start
CLANDRO_PKG_DESCRIPTION="Modern file manager for XFCE environment"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.8"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/thunar/${CLANDRO_PKG_VERSION%.*}/thunar-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=cc735954d948a88eba2e40016a94c598f876309b736686c9f4d0273a05870c69
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, desktop-file-utils, exo, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libexif, libice, libnotify, libsm, libx11, libxfce4ui, libxfce4util, pango, pcre2, shared-mime-info, xfce4-panel, xfconf, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, xfce4-dev-tools"
CLANDRO_PKG_RECOMMENDS="gvfs, hicolor-icon-theme, thunar-archive-plugin, tumbler"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--disable-static
--enable-gtk-doc-html=no
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
