CLANDRO_PKG_HOMEPAGE=https://btrfs.readthedocs.io/en/latest/
CLANDRO_PKG_DESCRIPTION="Utilities for Btrfs filesystem"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.19.1"
CLANDRO_PKG_SRCURL=https://github.com/kdave/btrfs-progs/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3213ab1c1f92a75ff181a08009bbb66a4899e168fdb57ca92a5f3045835e169c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="e2fsprogs, liblzo, libuuid, util-linux, zlib, zstd"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-backtrace
--disable-libudev
--disable-python
--disable-static
--disable-option-checking
"

clandro_step_pre_configure() {
	./autogen.sh
	CFLAGS+=" $CPPFLAGS"
}
