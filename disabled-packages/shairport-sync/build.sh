CLANDRO_PKG_HOMEPAGE=https://github.com/mikebrady/shairport-sync
CLANDRO_PKG_DESCRIPTION="An AirPlay audio player"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSES"
CLANDRO_PKG_MAINTAINER="@clandro"
# Cannot simply be updated to a newer version due to `pthread_cancel` being used
CLANDRO_PKG_VERSION=3.1.2
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://github.com/mikebrady/shairport-sync/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8c13f7ebbd417e8cab07ea9f74392ced0f54315d8697d4513580f472859a9c65
CLANDRO_PKG_DEPENDS="libconfig, libdaemon, libpopt, libsoxr, openssl, pulseaudio"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-pa
--with-soxr
--with-ssl=openssl
"

clandro_step_pre_configure() {
	autoreconf -fi

	CFLAGS+=" -fcommon"
}
