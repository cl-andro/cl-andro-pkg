CLANDRO_PKG_HOMEPAGE=https://rpm.org/
CLANDRO_PKG_DESCRIPTION="RPM Package Manager"
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_LICENSE_FILE="COPYING"
CLANDRO_PKG_MAINTAINER="@clandro"
_MAJOR_VERSION=4.18
CLANDRO_PKG_VERSION=${_MAJOR_VERSION}.1
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://ftp.osuosl.org/pub/rpm/releases/rpm-${_MAJOR_VERSION}.x/rpm-${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=37f3b42c0966941e2ad3f10fde3639824a6591d07197ba8fd0869ca0779e1f56
CLANDRO_PKG_DEPENDS="file, libandroid-spawn, libarchive, libbz2, libgcrypt, libiconv, lua54, liblzma, libpopt, libsqlite, readline, zlib, zstd"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--disable-openmp
"

clandro_step_pre_configure() {
	export LUA_CFLAGS="-I$CLANDRO_PREFIX/include/lua5.4"
	export LUA_LIBS="-L$CLANDRO_PREFIX/lib/liblua5.4.so"
	LDFLAGS+=" -llua5.4 -landroid-spawn $($CC -print-libgcc-file-name)"
}
