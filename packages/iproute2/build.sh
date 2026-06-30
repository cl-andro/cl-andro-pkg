CLANDRO_PKG_HOMEPAGE=https://wiki.linuxfoundation.org/networking/iproute2
CLANDRO_PKG_DESCRIPTION="Utilities for controlling networking"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.0.0"
CLANDRO_PKG_SRCURL=https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=e62890f7b5de63c05a3bf331dc8deb4c015c336013f341a4edf46969797f2f4e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-glob, libandroid-support"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--color=auto"

clandro_step_pre_configure() {
	CFLAGS+=" -fPIC"
	LDFLAGS+=" -landroid-glob"
}
