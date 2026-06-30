CLANDRO_PKG_HOMEPAGE=https://docs.xfce.org/xfce/garcon/start
CLANDRO_PKG_DESCRIPTION="Implementation of the freedesktop.org menu specification"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.20.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://archive.xfce.org/src/xfce/garcon/${CLANDRO_PKG_VERSION%.*}/garcon-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=7fb8517c12309ca4ddf8b42c34bc0c315e38ea077b5442bfcc4509415feada8f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libxfce4ui, libxfce4util, pango, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, xfce4-dev-tools"
CLANDRO_PKG_CONFLICTS="libgarcon"
CLANDRO_PKG_REPLACES="libgarcon"
CLANDRO_PKG_PROVIDES="libgarcon"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-debug
--enable-introspection=yes
--enable-gtk-doc-html=no
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
