# Contributor: @waruqi
CLANDRO_PKG_HOMEPAGE=https://xmake.io/
CLANDRO_PKG_DESCRIPTION="A cross-platform build utility based on Lua"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Ruki Wang @waruqi"
CLANDRO_PKG_VERSION="3.0.8"
CLANDRO_PKG_SRCURL=https://github.com/xmake-io/xmake/releases/download/v${CLANDRO_PKG_VERSION}/xmake-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=73da077440d1327e24bc74da2888c418e589dc28966e6e6b5bd6e889721b2d07
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_configure () {
	"$CLANDRO_PKG_SRCDIR"/configure --prefix="$CLANDRO_PREFIX"
}
