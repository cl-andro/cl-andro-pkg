CLANDRO_PKG_HOMEPAGE=https://github.com/tuxera/ntfs-3g
CLANDRO_PKG_DESCRIPTION="NTFS-3G Safe Read/Write NTFS Driver"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING, COPYING.LIB"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2026.2.25"
CLANDRO_PKG_SRCURL=https://github.com/tuxera/ntfs-3g/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=47de1260fa3fb1aa27d239a637f1178d29a04dd6add6ddff4ea5e47b806731f8
CLANDRO_PKG_DEPENDS="libfuse2"
CLANDRO_PKG_BUILD_DEPENDS="libgcrypt"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-fuse=external --exec-prefix=$CLANDRO_PREFIX --prefix=/"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	CFLAGS+=" -I${CLANDRO_PREFIX}/include/fuse"
	autoreconf -vfi
}

clandro_step_make_install() {
	make install \
		DESTDIR="$CLANDRO_PREFIX" \
		man8dir="/share/man/man8" \
		rootlibdir="/lib/" \
		libdir="/lib/" \
		rootbindir="/bin/" \
		bindir="/bin/" \
		sbindir="/bin" \
		includedir="/include"
}
