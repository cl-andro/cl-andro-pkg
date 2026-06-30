CLANDRO_PKG_HOMEPAGE=https://notroj.github.io/cadaver/
CLANDRO_PKG_DESCRIPTION="A command-line WebDAV client for Unix"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.28"
CLANDRO_PKG_SRCURL=https://notroj.github.io/cadaver/cadaver-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=33e3a54bd54b1eb325b48316a7cacc24047c533ef88e6ef98b88dfbb60e12734
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="libiconv, libneon, readline"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-nls
"

clandro_step_pre_configure() {
	./autogen.sh
}
