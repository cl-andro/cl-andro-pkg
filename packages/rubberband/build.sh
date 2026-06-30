CLANDRO_PKG_HOMEPAGE=https://breakfastquay.com/rubberband/
CLANDRO_PKG_DESCRIPTION="An audio time-stretching and pitch-shifting library and utility program"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://breakfastquay.com/files/releases/rubberband-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=af050313ee63bc18b35b2e064e5dce05b276aaf6d1aa2b8a82ced1fe2f8028e9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="fftw, libc++, libsamplerate, libsndfile"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-Dfft=fftw
-Dresampler=libsamplerate
"
