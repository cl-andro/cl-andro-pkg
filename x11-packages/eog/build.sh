CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/EyeOfGnome
CLANDRO_PKG_DESCRIPTION="Eye of GNOME, an image viewing and cataloging program"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="50.1"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/eog/${CLANDRO_PKG_VERSION%.*}/eog-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6f5ee6d756548b88e25a987e0d06dabc3c6c32598fb7df49fb08945c1fe94a55
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="gdk-pixbuf, glib, gnome-desktop3, gobject-introspection, gsettings-desktop-schemas, gtk3, libcairo, libexif, libhandy, libjpeg-turbo, libpeas, librsvg, libx11, littlecms, shared-mime-info, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_RECOMMENDS="eog-help"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dxmp=false
-Dintrospection=true
-Dlibportal=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
