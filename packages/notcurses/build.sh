CLANDRO_PKG_HOMEPAGE=https://notcurses.com/
CLANDRO_PKG_DESCRIPTION="blingful TUIs and character graphics"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.0.17"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/dankamongmen/notcurses/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b0fbe824984fe25b5a16770dbd00b85d44db5d09cc35bd881b95335d0db53128
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ffmpeg, libandroid-spawn, libc++, libunistring, ncurses, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_DOCTEST=OFF
-DUSE_DEFLATE=OFF
-DUSE_PANDOC=OFF
-DUSE_STATIC=OFF
"

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-spawn -lm"
}
