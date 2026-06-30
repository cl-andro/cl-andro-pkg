CLANDRO_PKG_HOMEPAGE=https://people.freedesktop.org/~hughsient/appstream-glib/
CLANDRO_PKG_DESCRIPTION="Provides GObjects and helper methods to make it easy to read and write AppStream metadata"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://people.freedesktop.org/~hughsient/appstream-glib/releases/appstream-glib-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=84754064c560fca6e1ab151dc64354fc235a5798f016b91b38c9617253a8cf11
CLANDRO_PKG_DEPENDS="fontconfig, freetype, gdk-pixbuf, glib, gtk3, json-glib, libarchive, libcairo, libcurl, libstemmer, libuuid, libyaml, pango"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Drpm=false
-Dgtk-doc=false
-Dintrospection=true
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
