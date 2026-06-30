CLANDRO_PKG_HOMEPAGE=https://libcec.pulse-eight.com/
CLANDRO_PKG_DESCRIPTION="Provides support for Pulse-Eight's USB-CEC adapter and other CEC capable hardware"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.1.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Pulse-Eight/libcec/archive/refs/tags/libcec-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7f7da95a4c1e7160d42ca37a3ac80cf6f389b317e14816949e0fa5e2edf4cc64
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="libc++, libp8-platform"

clandro_step_post_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 \
		$CLANDRO_PKG_SRCDIR/debian/cec-client.1
}
