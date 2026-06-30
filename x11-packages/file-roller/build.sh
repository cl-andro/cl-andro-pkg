CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/FileRoller
CLANDRO_PKG_DESCRIPTION="File Roller is an archive manager for the GNOME desktop environment."
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="44.6"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/file-roller/${CLANDRO_PKG_VERSION%.*}/file-roller-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=9e873b5005bc425799a8cd4b237e1fff430ec8d6b34a992c6033f1dfc6e3764e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, gtk4, json-glib, libadwaita, libarchive, pango"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_RECOMMENDS="arj, brotli, bsdtar, bzip2, cpio, file-roller-help, gzip, lz4, lzip, lzop, p7zip, tar, unrar, unzip, xz-utils, zip, zstd"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Duse_native_appchooser=false
-Dcpio=$CLANDRO_PREFIX/bin/cpio
-Dintrospection=enabled
"

clandro_step_pre_configure() {
	clandro_setup_gir
	clandro_setup_glib_cross_pkg_config_wrapper
}
