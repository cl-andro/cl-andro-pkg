CLANDRO_PKG_HOMEPAGE=https://miniupnp.tuxfamily.org/libnatpmp.html
CLANDRO_PKG_DESCRIPTION="Portable and fully compliant implementation of NAT-PMP"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=20230423
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://miniupnp.tuxfamily.org/files/libnatpmp-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=0684ed2c8406437e7519a1bd20ea83780db871b3a3a5d752311ba3e889dbfc70
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="INSTALLPREFIX=$CLANDRO_PREFIX"

clandro_step_post_get_source() {
	mv setup.py{,.unused}
}

clandro_step_configure() {
	:
}
