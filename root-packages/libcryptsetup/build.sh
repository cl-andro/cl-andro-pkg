CLANDRO_PKG_HOMEPAGE=https://gitlab.com/cryptsetup/cryptsetup/
CLANDRO_PKG_DESCRIPTION="Userspace setup tool for transparent encryption of block devices using dm-crypt"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.8.6
CLANDRO_PKG_SRCURL=https://mirrors.edge.kernel.org/pub/linux/utils/cryptsetup/v${CLANDRO_PKG_VERSION:0:3}/cryptsetup-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=8004265fd993885d08f7b633dbe056851de1a210307613a4ebddc743fccefe5a
CLANDRO_PKG_DEPENDS="json-c, libblkid, libdevmapper, libgcrypt, libuuid, openssl, libiconv, argon2"
CLANDRO_PKG_BREAKS="cryptsetup-dev, cryptsetup (<< 2.4.3-1)"
CLANDRO_PKG_REPLACES="cryptsetup-dev, cryptsetup (<< 2.4.3-1)"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-luks2-lock-path=$CLANDRO_PREFIX/var/run
--enable-libargon2
--disable-ssh-token
"

clandro_step_pre_configure() {
	export LDFLAGS+=" -liconv"
}
