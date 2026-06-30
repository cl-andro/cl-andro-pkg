CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Evince
CLANDRO_PKG_DESCRIPTION="document viewer for multiple document formats"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="48.1"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/evince/${CLANDRO_PKG_VERSION%%.*}/evince-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=7d8b9a6fa3a05d3f5b9048859027688c73a788ff6e923bc3945126884943fa10
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, djvulibre, gdk-pixbuf, glib, gnome-desktop3, gst-plugins-base, gst-plugins-good, gstreamer, gtk3, libarchive, libcairo, libgxps, libhandy, libsecret, libspectre, libtiff, libxml2, pango, poppler, poppler-data, texlive-bin"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_RECOMMENDS="evince-help"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dnautilus=false
-Dps=enabled
-Dgtk_doc=false
-Dintrospection=true
-Dgspell=disabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
