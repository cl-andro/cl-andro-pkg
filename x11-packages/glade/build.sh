CLANDRO_PKG_HOMEPAGE=https://glade.gnome.org/
CLANDRO_PKG_DESCRIPTION="User interface designer for Gtk+ and GNOME"
CLANDRO_PKG_LICENSE="LGPL-2.0, GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.40.0"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/glade/${CLANDRO_PKG_VERSION%.*}/glade-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=31c9adaea849972ab9517b564e19ac19977ca97758b109edc3167008f53e3d9c
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libxml2, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, xsltproc"
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgjs=disabled
-Dpython=disabled
-Dwebkit2gtk=disabled
-Dintrospection=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
