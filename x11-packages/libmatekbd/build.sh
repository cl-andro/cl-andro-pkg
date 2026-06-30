CLANDRO_PKG_HOMEPAGE=https://libmatekbd.mate-desktop.dev/
CLANDRO_PKG_DESCRIPTION="libmatekbd is a fork of libgnomekbd"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.28.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/mate-desktop/libmatekbd/releases/download/v$CLANDRO_PKG_VERSION/libmatekbd-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=5d2e58483c2b23d33503d24c88f8b90a28cc0189d7e4001b3e273a604f6fe80e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libx11, libxklavier, pango, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
LIBXKLAVIER=${CLANDRO_PREFIX}/lib/libxklavier.so
--enable-introspection=yes
"

clandro_step_pre_configure() {
	clandro_setup_gir

	export GLIB_COMPILE_RESOURCES="glib-compile-resources"
	export GLIB_COMPILE_SCHEMAS="glib-compile-schemas"
}
