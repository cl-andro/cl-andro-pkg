CLANDRO_PKG_HOMEPAGE=https://premake.github.io/
CLANDRO_PKG_DESCRIPTION="Build script generator"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.0.0-beta1
CLANDRO_PKG_SRCURL=https://github.com/premake/premake-core/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=97fa4cef9fb6459c39da4e70756c0e13ae7b090fffe9442306c768b8b62e1589
# CLANDRO_PKG_DEPENDS="pcre, openssl, libuuid"
# CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-ssl=openssl"


clandro_step_pre_configure() {
	CLANDRO_PKG_BUILDDIR=$CLANDRO_PKG_SRCDIR/build/gmake.unix
}
