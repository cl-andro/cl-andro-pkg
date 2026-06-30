CLANDRO_PKG_HOMEPAGE=https://github.com/opsengine/cpulimit
CLANDRO_PKG_DESCRIPTION="CPU usage limiter"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.2
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/opsengine/cpulimit/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=64312f9ac569ddcadb615593cd002c94b76e93a0d4625d3ce1abb49e08e2c2da
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"
	CFLAGS+=" $CPPFLAGS"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin src/cpulimit
}
