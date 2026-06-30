CLANDRO_PKG_HOMEPAGE=https://feh.finalrewind.org/
CLANDRO_PKG_DESCRIPTION="Fast and light imlib2-based image viewer"
# License: MIT-feh
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.12.2"
CLANDRO_PKG_SRCURL=https://feh.finalrewind.org/feh-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=7ce358b18a7f37bcc97a09b4efd89fdadd54cd8e7032db345f61e66dd04b1c3f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="imlib2, libcurl, libexif, libpng, libx11, libxinerama"
CLANDRO_PKG_BUILD_DEPENDS="libxt"
CLANDRO_PKG_RECOMMENDS="libjpeg-turbo-progs"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="exif=1 help=1 verscmp=0"

clandro_step_pre_configure() {
	CFLAGS+=" -I${CLANDRO_PREFIX}/include"
}
