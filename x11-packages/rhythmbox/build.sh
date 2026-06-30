CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/rhythmbox
CLANDRO_PKG_DESCRIPTION="Music playback and management application"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.4.9"
CLANDRO_PKG_SRCURL="https://download.gnome.org/sources/rhythmbox/${CLANDRO_PKG_VERSION%.*}/rhythmbox-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=e42291a18df7a21ffe6b352bf73f05d7e298bb4e05bce5967f98ee8cee4408f1
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="at-spi2-core, gdk-pixbuf, glib, gobject-introspection, gst-plugins-base, gstreamer, gtk3, json-glib, libcairo, libnotify, libpeas, libsoup3, libtdb, libx11, libxml2, pango, pygobject, python, totem-pl-parser"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
CLANDRO_PKG_RECOMMENDS="rhythmbox-help"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dapidoc=false
-Dhelp=true
-Dplugins_python=enabled
-Dplugins_vala=enabled
-Dtests=disabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
