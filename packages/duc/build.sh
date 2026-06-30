CLANDRO_PKG_HOMEPAGE=http://duc.zevv.nl/
CLANDRO_PKG_DESCRIPTION="High-performance disk usage analyzer"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.4.6"
CLANDRO_PKG_SRCURL=https://github.com/zevv/duc/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1ae6d31394cc3fa7c44a9e4449baa405865c6c0ee447546a3cd8af6c642dda11
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="leveldb, ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-x11
--with-db-backend=leveldb
--disable-cairo"

clandro_step_pre_configure() {
	autoreconf -fiv
}
