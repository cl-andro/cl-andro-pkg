CLANDRO_PKG_HOMEPAGE=https://rsync.samba.org/
CLANDRO_PKG_DESCRIPTION="Fast incremental file transfer utility"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="3.4.2"
CLANDRO_PKG_SRCURL=https://rsync.samba.org/ftp/rsync/src/rsync-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ff10aa2c151cd4b2dbbe6135126dbc854046113d2dfb49572a348233267eb315
CLANDRO_PKG_DEPENDS="libiconv, liblz4, libpopt, openssh | dropbear, openssl, openssl-tool, xxhash, zlib, zstd"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-rsyncd-conf=$CLANDRO_PREFIX/etc/rsyncd.conf
--with-included-popt=no
--with-included-zlib=no
--enable-ipv6=yes
--disable-debug
--disable-simd
--disable-xattr-support
--enable-xxhash
"
