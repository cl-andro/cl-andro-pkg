CLANDRO_PKG_HOMEPAGE=https://www.portaudio.com/
CLANDRO_PKG_DESCRIPTION="A portable audio I/O library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=19.07.00
CLANDRO_PKG_REVISION=3
# There are no tags or releases in the last few years, but there are a lot of new commits
CLANDRO_PKG_SRCURL=https://github.com/PortAudio/portaudio/archive/57aa393109ec996799d3a5846c9ecb0a65b64644.tar.gz
CLANDRO_PKG_SHA256=935d3e8b93baa057bb4bf114520687c21e57129a1c1df014c41dd51fb35be3c2
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_DEPENDS="libc++"
# Pulseaudio backend does not work, audacity hangs.
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-cxx
--without-alsa
--without-jack
--without-oss
--without-asihpi
--without-pulseaudio
ac_cv_lib_pthread_pthread_create=yes
ac_cv_lib_rt_clock_gettime=yes
"
CLANDRO_PKG_MAKE_PROCESSES=1

clandro_step_post_get_source() {
	local _URL0="https://github.com/croissanne/portaudio_opensles/raw/3cab75108027588430c613d12eeef37d820c98d1/src/hostapi/opensles/pa_opensles.c"
	local _URL1="https://github.com/croissanne/portaudio_opensles/raw/3cab75108027588430c613d12eeef37d820c98d1/include/pa_opensles.h"
	clandro_download $_URL0 $CLANDRO_PKG_CACHEDIR/${_URL0##*/} 64cf987beceba200fdbc0e217eb07d8ad87c91766ba41bf68f696de2b191214f
	clandro_download $_URL1 $CLANDRO_PKG_CACHEDIR/${_URL1##*/} 3cc8feefdd0e76d52425a48244c73dac73343c3b89b7c5827c8226a42aef4d32
	cp $CLANDRO_PKG_CACHEDIR/pa_opensles.c $CLANDRO_PKG_CACHEDIR/pa_opensles.h $CLANDRO_PKG_SRCDIR/
	touch $CLANDRO_PKG_SRCDIR/pa_opensles.h
	rm -rf $CLANDRO_PKG_MASSAGEDIR
	mkdir -p $CLANDRO_PKG_MASSAGEDIR
}
