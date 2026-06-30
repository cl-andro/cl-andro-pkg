CLANDRO_PKG_HOMEPAGE=https://wiki.gnome.org/libgxps
CLANDRO_PKG_DESCRIPTION="handling and rendering XPS documents"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=0.3
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.2
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libgxps/${_MAJOR_VERSION}/libgxps-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=6d27867256a35ccf9b69253eb2a88a32baca3b97d5f4ef7f82e3667fa435251c
CLANDRO_PKG_DEPENDS="freetype, glib, libarchive, libcairo, libjpeg-turbo, libpng, libtiff, littlecms"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_DISABLE_GIR=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-test=false
-Denable-man=true
-Ddisable-introspection=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
