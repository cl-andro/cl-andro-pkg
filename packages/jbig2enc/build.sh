CLANDRO_PKG_HOMEPAGE=https://github.com/agl/jbig2enc
CLANDRO_PKG_DESCRIPTION="An encoder for JBIG2"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:0.31"
CLANDRO_PKG_SRCURL="https://github.com/agl/jbig2enc/archive/refs/tags/${CLANDRO_PKG_VERSION:2}.tar.gz"
CLANDRO_PKG_SHA256=35c255e44a9b1c4cbe27d2c84594a43d6666645156a2d186ba60f8832566141d
CLANDRO_PKG_DEPENDS="giflib, leptonica, libc++, libjpeg-turbo, libpng, libtiff, libwebp, python, zlib"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	sh autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
