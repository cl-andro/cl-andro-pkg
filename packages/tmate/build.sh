CLANDRO_PKG_HOMEPAGE=https://tmate.io
CLANDRO_PKG_DESCRIPTION="Terminal multiplexer with instant terminal sharing"
CLANDRO_PKG_LICENSE="ISC"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.4.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/tmate-io/tmate/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=62b61eb12ab394012c861f6b48ba0bc04ac8765abca13bdde5a4d9105cb16138
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libevent, libmsgpack, libssh, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"

clandro_step_pre_configure() {
	CFLAGS+=" -DIOV_MAX=1024"

	./autogen.sh
}
