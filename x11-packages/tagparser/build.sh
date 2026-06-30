CLANDRO_PKG_HOMEPAGE=https://github.com/Martchus/tagparser
CLANDRO_PKG_DESCRIPTION="C++ library for reading and writing MP4 (iTunes), ID3, Vorbis, Opus, FLAC and Matroska tags"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="12.5.2"
CLANDRO_PKG_SRCURL=https://github.com/Martchus/tagparser/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=eb9a8e1f736f053fe44632bfc45906f1e4f76fecf01a406fc4d570165d2101f9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libc++utilities, zlib"
CLANDRO_PKG_BUILD_DEPENDS="iso-codes"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DLANGUAGE_FILE_ISO_639_2=$CLANDRO_PREFIX/share/iso-codes/json/iso_639-2.json
"

clandro_step_pre_configure() {
	CXXFLAGS+=" -std=c++17"
}
