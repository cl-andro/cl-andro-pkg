CLANDRO_PKG_HOMEPAGE=https://lib.openmpt.org/libopenmpt/
CLANDRO_PKG_DESCRIPTION="Library to render tracker music formats to a PCM audio stream"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.6"
CLANDRO_PKG_SRCURL=https://lib.openmpt.org/files/libopenmpt/src/libopenmpt-${CLANDRO_PKG_VERSION}+release.autotools.tar.gz
CLANDRO_PKG_SHA256=caa2fa959e389f4374d9e2df3af5c633452c12dd80442cba2e89cb7ff2b93c5b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_DEPENDS="libflac, libogg, libsndfile, pulseaudio"
CLANDRO_PKG_DEPENDS="libc++, libvorbis, libmpg123, zlib"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--without-portaudio
--without-portaudiocpp
"

clandro_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
	CXXFLAGS+=" -std=c++17"
}

clandro_step_post_configure() {
	# despite linking with libogg, libogg is not a dependency of libopenmpt or openmpt123
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
