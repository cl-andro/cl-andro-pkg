CLANDRO_PKG_HOMEPAGE=https://ccextractor.org/
CLANDRO_PKG_DESCRIPTION="A tool used to produce subtitles for TV recordings"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.94
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://github.com/CCExtractor/ccextractor/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9c7be386257c69b5d8cd9d7466dbf20e3a45cea950cc8ca7486a956c3be54a42
CLANDRO_PKG_DEPENDS="freetype, gpac, libiconv, libmd, libpng, libprotobuf-c, utf8proc"
CLANDRO_PKG_BUILD_DEPENDS="zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
-DWITHOUT_RUST=ON
"

clandro_step_post_get_source() {
	rm -rf src/thirdparty
	touch src/lib_ccx/config.h
}

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR+="/src"

	CPPFLAGS+=" -D__USE_GNU"
	CFLAGS+=" -fcommon"
	LDFLAGS+=" -liconv"
}
