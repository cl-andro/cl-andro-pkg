CLANDRO_PKG_HOMEPAGE=https://github.com/mchehab/zbar
CLANDRO_PKG_DESCRIPTION="Software suite for reading bar codes from various sources"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.23.93"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/mchehab/zbar/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=212dfab527894b8bcbcc7cd1d43d63f5604a07473d31a5f02889e372614ebe28
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="imagemagick, libiconv, libjpeg-turbo"
CLANDRO_PKG_BREAKS="zbar-dev"
CLANDRO_PKG_REPLACES="zbar-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-pthread
--disable-video --without-xshm --without-xv
--without-x --without-gtk --without-qt
--without-python --mandir=$CLANDRO_PREFIX/share/man"

clandro_step_pre_configure() {
	autoreconf -vfi
}
