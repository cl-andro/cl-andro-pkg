CLANDRO_PKG_HOMEPAGE=http://lynx.browser.org/
CLANDRO_PKG_DESCRIPTION="The text web browser"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.9.2
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://invisible-mirror.net/archives/lynx/tarballs/lynx${CLANDRO_PKG_VERSION}.tar.bz2
CLANDRO_PKG_SHA256=7374b89936d991669e101f4e97f2c9592036e1e8cdaa7bafc259a77ab6fb07ce
CLANDRO_PKG_DEPENDS="brotli, libiconv, ncurses, openssl, libbz2, libidn, zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-screen=ncursesw --enable-widec --enable-scrollbar --enable-nested-tables --enable-htmlized-cfg --with-ssl --with-zlib --with-bzlib --enable-cjk --enable-japanese-utf8 --enable-progressbar --enable-prettysrc --enable-forms-options --enable-8bit-toupper --enable-ascii-ctypes --disable-font-switch --with-mime-libdir=$CLANDRO_PREFIX/etc"

## set default paths for tools that may be used in runtime by 'lynx' binary
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_BROTLI=${CLANDRO_PREFIX}/bin/brotli"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_BZIP2=${CLANDRO_PREFIX}/bin/bzip2"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_COMPRESS=${CLANDRO_PREFIX}/bin/compress"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_GZIP=${CLANDRO_PREFIX}/bin/gzip"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_INSTALL=${CLANDRO_PREFIX}/bin/install"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MSGINIT=${CLANDRO_PREFIX}/bin/msginit"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MV=${CLANDRO_PREFIX}/bin/mv"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_RM=${CLANDRO_PREFIX}/bin/rm"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TAR=${CLANDRO_PREFIX}/bin/tar"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TELNET=${CLANDRO_PREFIX}/bin/telnet"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNCOMPRESS=${CLANDRO_PREFIX}/bin/uncompress"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNZIP=${CLANDRO_PREFIX}/bin/unzip"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UUDECODE=${CLANDRO_PREFIX}/bin/uudecode"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZCAT=${CLANDRO_PREFIX}/bin/zcat"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZIP=${CLANDRO_PREFIX}/bin/zip"

clandro_step_pre_configure() {
	CC+=" $LDFLAGS"
	unset LDFLAGS
}

clandro_step_make_install() {
	make uninstall
	make install
}
