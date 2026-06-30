CLANDRO_PKG_HOMEPAGE=https://www.stunprotocol.org/
CLANDRO_PKG_DESCRIPTION="An open source STUN server"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.16"
CLANDRO_PKG_REVISION=7
CLANDRO_PKG_SRCURL="https://www.stunprotocol.org/stunserver-${CLANDRO_PKG_VERSION}.tgz"
CLANDRO_PKG_SHA256=4479e1ae070651dfc4836a998267c7ac2fba4f011abcfdca3b8ccd7736d4fd26
CLANDRO_PKG_DEPENDS="libc++, openssl"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="T=" # In case if environment variable `T` is defined

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin "$CLANDRO_PKG_BUILDDIR/stunclient"
	install -Dm700 -t $CLANDRO_PREFIX/bin "$CLANDRO_PKG_BUILDDIR/stunserver"
}
