CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/exo/start
CLANDRO_PKG_DESCRIPTION="Application library for XFCE"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.21.0"
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/exo/${CLANDRO_PKG_VERSION%.*}/exo-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=26f85ca2db3bcf99d8b8af28b0d565b0186ccc3d2ed4a5ba315f6a589b8bc2c9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libxfce4ui, libxfce4util, pango, zlib"
CLANDRO_PKG_BUILD_DEPENDS="xfce4-dev-tools"
CLANDRO_PKG_RECOMMENDS="hicolor-icon-theme"
CLANDRO_PKG_CONFLICTS="libexo"
CLANDRO_PKG_REPLACES="libexo"
CLANDRO_PKG_PROVIDES="libexo"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--enable-gtk-doc-html=no
"
