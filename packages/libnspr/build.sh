CLANDRO_PKG_HOMEPAGE=https://hg.mozilla.org/projects/nspr
CLANDRO_PKG_DESCRIPTION="Netscape Portable Runtime (NSPR)"
CLANDRO_PKG_LICENSE="MPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.39"
CLANDRO_PKG_SRCURL=https://archive.mozilla.org/pub/nspr/releases/v${CLANDRO_PKG_VERSION}/src/nspr-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bbd02ee87a55676063a63e5bc819e0227de2666b47307b2a0134414cdf42368e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_post_get_source() {
	CLANDRO_PKG_SRCDIR+="/nspr"
}

clandro_step_pre_configure() {
	CPPFLAGS+=" -DANDROID"
	LDFLAGS+=" -llog"

	if [ $CLANDRO_ARCH_BITS -eq 64 ]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-64bit"
	fi

	CLANDRO_PKG_EXTRA_MAKE_ARGS+="
		NSINSTALL=$CLANDRO_PKG_HOSTBUILD_DIR/config/nsinstall
		NOW=$CLANDRO_PKG_HOSTBUILD_DIR/config/now
		"
}
