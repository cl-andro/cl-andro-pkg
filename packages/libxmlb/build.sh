CLANDRO_PKG_HOMEPAGE="https://github.com/hughsie/libxmlb"
CLANDRO_PKG_DESCRIPTION="Library to help create and query binary XML blobs"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.3.26"
CLANDRO_PKG_SRCURL=https://github.com/hughsie/libxmlb/releases/download/${CLANDRO_PKG_VERSION}/libxmlb-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=a18bc447fff0dd0d76a2e6cd4a603b4712047c027f9bbbdc31ebc25f0e2c1ed9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, liblzma, libstemmer, zstd"
CLANDRO_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross"
CLANDRO_PKG_VERSIONED_GIR=false
CLANDRO_PKG_DISABLE_GIR=false
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtkdoc=false
-Dintrospection=true
-Dstemmer=true
-Dtests=false
"

clandro_step_pre_configure() {
	clandro_setup_gir
}
