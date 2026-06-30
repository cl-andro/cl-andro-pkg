CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/xorriso
CLANDRO_PKG_DESCRIPTION="Tool for creating ISO files"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:1.5.8.pl01"
CLANDRO_PKG_SRCURL=https://www.gnu.org/software/xorriso/xorriso-${CLANDRO_PKG_VERSION:2}.tar.gz
CLANDRO_PKG_SHA256=0381798b7bb4f162578b4f31fe30bfe53608b5077075967f8df2facfab4c90f9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libiconv, libandroid-support, readline, libbz2, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-jtethreads"

clandro_step_pre_configure() {
	./bootstrap
}
