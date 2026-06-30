# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://www.cgsecurity.org/wiki/TestDisk
CLANDRO_PKG_DESCRIPTION="Partition Recovery and File Undelete"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=7.1
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://www.cgsecurity.org/testdisk-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=1413c47569e48c5b22653b943d48136cb228abcbd6f03da109c4df63382190fe
CLANDRO_PKG_DEPENDS="libuuid, zlib, libjpeg-turbo, libiconv, ncurses, libandroid-glob"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--bindir=$CLANDRO_PREFIX/bin
--sysconfdir=$CLANDRO_PREFIX/etc
--localstatedir=$CLANDRO_PREFIX/var
--mandir=$CLANDRO_PREFIX/share/man
--without-ewf
--without-ntfs3g
--without-ntfs
--without-reiserfs
"

clandro_step_pre_configure() {
	export LIBS="-lncurses -landroid-glob"
}

clandro_step_make() {
	make -j2 static
}
