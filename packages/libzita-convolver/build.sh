CLANDRO_PKG_HOMEPAGE=https://kokkinizita.linuxaudio.org/linuxaudio/
CLANDRO_PKG_DESCRIPTION="A real-time C++ convolution library"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.0.3
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://kokkinizita.linuxaudio.org/linuxaudio/downloads/zita-convolver-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=9aa11484fb30b4e6ef00c8a3281eebcfad9221e3937b1beb5fe21b748d89325f
CLANDRO_PKG_DEPENDS="libc++, fftw"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
-C source
PREFIX=$CLANDRO_PREFIX
"
