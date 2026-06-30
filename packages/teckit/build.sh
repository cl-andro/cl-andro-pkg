CLANDRO_PKG_HOMEPAGE=https://scripts.sil.org/teckitdownloads
CLANDRO_PKG_DESCRIPTION="TECkit is a library for encoding conversion"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION="2.5.13"
CLANDRO_PKG_SRCURL=https://github.com/silnrsi/teckit/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=fa8455324402e890e814f0262e7409dbc8f2a4fd8375c37a11a38ccfc32d3eff
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, zlib"
CLANDRO_PKG_BREAKS="teckit-dev"
CLANDRO_PKG_REPLACES="teckit-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_expat_XML_ExpatVersion=no"

clandro_step_pre_configure() {
	./autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
