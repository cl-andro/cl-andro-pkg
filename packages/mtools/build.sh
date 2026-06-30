CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/mtools/
CLANDRO_PKG_DESCRIPTION="Tool for manipulating FAT images"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.0.49"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/mtools/mtools-${CLANDRO_PKG_VERSION}.tar.lz
CLANDRO_PKG_SHA256=76dfea98d923dfc9806ce34bd1786aa9b5a39d70f56f26c0670a348c664f1d2a
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libandroid-support, libiconv"

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-floppyd
ac_cv_lib_bsd_main=no
"

clandro_step_pre_configure() {
	export LIBS="-liconv"
}
