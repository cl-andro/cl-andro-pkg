CLANDRO_PKG_HOMEPAGE=https://serf.apache.org/
CLANDRO_PKG_DESCRIPTION="High performance C-based HTTP client library"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.10
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://archive.apache.org/dist/serf/serf-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=be81ef08baa2516ecda76a77adf7def7bc3227eeb578b9a33b45f7b41dc064e6
CLANDRO_PKG_DEPENDS="apr, apr-util, openssl, zlib"
CLANDRO_PKG_BREAKS="serf-dev"
CLANDRO_PKG_REPLACES="serf-dev"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	scons \
		APR=$CLANDRO_PREFIX \
		APU=$CLANDRO_PREFIX \
		CC=$(command -v $CC) \
		CFLAGS="$CFLAGS" \
		CPPFLAGS="$CPPFLAGS" \
		LINKFLAGS="$LDFLAGS" \
		OPENSSL=$CLANDRO_PREFIX \
		PREFIX=$CLANDRO_PREFIX \
		install
}
