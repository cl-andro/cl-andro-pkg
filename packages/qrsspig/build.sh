CLANDRO_PKG_HOMEPAGE=https://gitlab.com/hb9fxx/qrsspig
CLANDRO_PKG_DESCRIPTION="Headless QRSS grabber for Raspberry Pi's"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.0"
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL="https://gitlab.com/hb9fxx/qrsspig/-/archive/v${CLANDRO_PKG_VERSION}/qrsspig-v${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=9b3df7723944ef15f99d355ed071f41ace663833afe46703036ead89415372d1
CLANDRO_PKG_DEPENDS="boost, fftw, libc++, libcurl, libgd, libliquid-dsp, libssh, libyaml-cpp, pulseaudio"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_POLICY_VERSION_MINIMUM=3.5"

clandro_step_pre_configure() {
	LDFLAGS+=" -llog"
}

clandro_step_post_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/etc/qrsspig \
		$CLANDRO_PKG_SRCDIR/etc/qrsspig.yaml
}
