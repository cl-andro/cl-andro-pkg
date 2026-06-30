CLANDRO_PKG_HOMEPAGE=https://www.gcd.org/sengoku/stone/
CLANDRO_PKG_DESCRIPTION="A TCP/IP repeater in the application layer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.4
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://www.gcd.org/sengoku/stone/stone-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=d5dc1af6ec5da503f2a40b3df3fe19a8fbf9d3ce696b8f46f4d53d2ac8d8eb6f
CLANDRO_PKG_DEPENDS="openssl"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-e stone"

clandro_step_configure() {
	CFLAGS+=" $CPPFLAGS"
	export FLAGS="-DUSE_SSL -DUNIX_DAEMON -DNO_RINDEX -DUSE_EPOLL -DPTHREAD -DPRCTL -UANDROID"
	export LIBS="$LDFLAGS -lssl -lcrypto"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin stone
}
