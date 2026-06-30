CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/zenity
CLANDRO_PKG_DESCRIPTION="a rewrite of gdialog, the GNOME port of dialog"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.2.2"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/zenity/${CLANDRO_PKG_VERSION%.*}/zenity-$CLANDRO_PKG_VERSION.tar.xz"
CLANDRO_PKG_SHA256=019186a996096ef4fc356e21577b5673f5baa3a29ac8e3d608b753371c18018d
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libadwaita, libx11, pango, webkitgtk-6.0"
CLANDRO_PKG_BUILD_DEPENDS="glib-cross"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dwebkitgtk=true
-Dmanpage=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
