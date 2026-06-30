CLANDRO_PKG_HOMEPAGE=https://timg.sh/
CLANDRO_PKG_DESCRIPTION="A terminal image and video viewer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.3"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/hzeller/timg/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=59c908867f18c81106385a43065c232e63236e120d5b2596b179ce56340d7b01
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="ffmpeg, graphicsmagick, libc++, libcairo, libdeflate, libjpeg-turbo, libexif, librsvg, libsixel, poppler, zlib"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_VIDEO_DECODING=on
-DWITH_OPENSLIDE_SUPPORT=off
-DWITH_GRAPHICSMAGICK=on
-DWITH_TURBOJPEG=on
-DWITH_STB_IMAGE=off
-DWITH_POPPLER=on
-DWITH_LIBSIXEL=on
-DWITH_RSVG=on
"

clandro_step_pre_configure() {
	# error: non-constant-expression cannot be narrowed from type 'int64_t' to 'time_t' in initializer list [-Wc++11-narrowing]
	CXXFLAGS+=" -Wno-c++11-narrowing"
}
