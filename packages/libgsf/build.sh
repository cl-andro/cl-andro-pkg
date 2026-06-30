CLANDRO_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libgsf
CLANDRO_PKG_DESCRIPTION="The G Structured File Library"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.14.58"
CLANDRO_PKG_SRCURL=https://download.gnome.org/sources/libgsf/${CLANDRO_PKG_VERSION%.*}/libgsf-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=06e07ea12b7a52b9e316faddfecb640b1717a4875c59f0efb3b0cec1e2ccf35a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libbz2, libxml2, zlib"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection
--with-bz2
--without-gdk-pixbuf
"

clandro_step_pre_configure() {
	clandro_setup_gir
	CFLAGS+=" -I${CLANDRO_PREFIX}/include/libxml2 -includelibxml/xmlerror.h"
}

clandro_step_post_configure() {
	touch ./gsf/g-ir-scanner
}
