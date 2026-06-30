CLANDRO_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
CLANDRO_PKG_DESCRIPTION="Library for reading information from media files"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_LICENSE_FILE="../../../LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.01"
CLANDRO_PKG_SRCURL=https://github.com/MediaArea/MediaInfoLib/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=941daa01fce4595bd7b56c4d2db166f58e2bb2362dcb9636b952ee29b64db986
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libcurl, libzen, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--enable-shared --enable-static --with-libcurl"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR="${CLANDRO_PKG_SRCDIR}/Project/GNU/Library"
	CLANDRO_PKG_BUILDDIR="${CLANDRO_PKG_SRCDIR}"
	cd "${CLANDRO_PKG_SRCDIR}"
	./autogen.sh
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
