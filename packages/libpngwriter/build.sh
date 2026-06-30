CLANDRO_PKG_HOMEPAGE=https://pngwriter.sourceforge.net
CLANDRO_PKG_DESCRIPTION="C++ library for creating PNG images"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/pngwriter/pngwriter/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=82d46eef109f434f95eba9cf5908710ae4e75f575fd3858178ad06e800152825
CLANDRO_PKG_DEPENDS="zlib,freetype,libpng"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_post_make_install() {
	mv "$CLANDRO_PREFIX"/lib/libPNGwriter_shared.so libPNGwriter.so
}
