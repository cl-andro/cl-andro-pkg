# Dead upstream.
CLANDRO_PKG_HOMEPAGE=https://packages.gentoo.org/packages/media-video/transcode
CLANDRO_PKG_DESCRIPTION="A video stream processing utility"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.1.7
CLANDRO_PKG_SRCURL=(https://ftp-osl.osuosl.org/pub/gentoo/distfiles/transcode-${CLANDRO_PKG_VERSION}.tar.bz2
                   https://dev.gentoo.org/~mgorny/dist/transcode-${CLANDRO_PKG_VERSION}-patchset.tar.bz2)
CLANDRO_PKG_SHA256=(1e4e72d8e0dd62a80b8dd90699f5ca64c9b0cb37a5c9325c184166a9654f0a92
                   487866077b7227fe9921b742edea9d01749edb3b7e50162923c6a60748d94248)
CLANDRO_PKG_DEPENDS="freetype, gawk, imagemagick, libandroid-glob, libandroid-shmem, libdvdread, libjpeg-turbo, liblzo, libmp3lame, libogg, libtheora, libvorbis, libxml2, zlib"
CLANDRO_PKG_BUILD_DEPENDS="libiconv, libx264, xvidcore"
# FFmpeg 5.0 is not yet supported by the current patchset.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-ffmpeg
--enable-freetype2
--enable-xvid
--enable-x264
--enable-ogg
--enable-vorbis
--enable-theora
--enable-lzo
--enable-libxml2
--enable-imagemagick
--with-x=no
"
clandro_step_post_get_source() {
	local _PATCH_FILES="
		transcode-1.1.7-freetype251.patch
		transcode-1.1.7-imagemagick7.patch
		"
	pushd transcode-${CLANDRO_PKG_VERSION}-patchset
	cat ${_PATCH_FILES} | patch --silent -p1 -d ..
	popd
}

clandro_step_pre_configure() {
	autoreconf -fi

	CFLAGS+=" -fcommon"
	LDFLAGS+=" -landroid-glob -landroid-shmem"

	local p
	for p in lame xvid libdvdread pvm3 lzo a52 faac libjpegmmx libjpeg bsdav iconv; do
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+="
			--with-${p}-prefix=$CLANDRO_PREFIX
			--with-${p}-includes=$CLANDRO_PREFIX/include
			--with-${p}-libs=$CLANDRO_PREFIX/lib
			"
	done

	if [ "$CLANDRO_ARCH" = "i686" ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --disable-mmx"
	fi
}
