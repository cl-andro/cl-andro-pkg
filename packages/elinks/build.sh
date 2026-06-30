CLANDRO_PKG_HOMEPAGE=https://github.com/rkd77/elinks
CLANDRO_PKG_DESCRIPTION="Full-Featured Text WWW Browser"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.19.1"
CLANDRO_PKG_SRCURL=https://github.com/rkd77/elinks/releases/download/v${CLANDRO_PKG_VERSION}/elinks-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=31960cd471246692b84008bffec89182f25818472f86ee1a41a09bf0dad09eeb
CLANDRO_PKG_DEPENDS="libandroid-execinfo, libexpat, libiconv, libidn, openssl, libbz2, zlib"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-256-colors
--enable-true-color
--mandir=$CLANDRO_PREFIX/share/man
--with-openssl
--without-brotli
--without-zstd
"

CLANDRO_PKG_MAKE_PROCESSES=1

clandro_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
	./autogen.sh
}
