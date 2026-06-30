CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/gnome-menus
CLANDRO_PKG_DESCRIPTION="GNOME menu specifications"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.38.1
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/gnome-menus/${CLANDRO_PKG_VERSION%.*}/gnome-menus-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=1198a91cdbdcfb232df94e71ef5427617d26029e327be3f860c3b0921c448118
CLANDRO_PKG_DEPENDS="glib"
CLANDRO_PKG_BUILD_DEPENDS="gobject-introspection"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false

clandro_step_pre_configure() {
	clandro_setup_gir
	autoreconf -fi
}
