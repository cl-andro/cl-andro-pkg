CLANDRO_PKG_HOMEPAGE=https://github.com/ckolivas/lrzip
CLANDRO_PKG_DESCRIPTION="A compression utility that excels at compressing large files"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.660"
CLANDRO_PKG_SRCURL="https://github.com/ckolivas/lrzip/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=fd2cb18fc166e565a23f3415306d71a0f9151e0f1d7016d9a2c7eb038cd3c159
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE=newest-tag
CLANDRO_PKG_DEPENDS="bash, libbz2, libc++, liblz4, liblzo, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-asm=no
"
# Avoid conflicting with lrzsz.
CLANDRO_PKG_RM_AFTER_INSTALL="
bin/lrz
share/man/man1/lrz.1
"

clandro_step_pre_configure() {
	autoreconf -fi
}
