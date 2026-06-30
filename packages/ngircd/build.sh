CLANDRO_PKG_HOMEPAGE=https://ngircd.barton.de/
CLANDRO_PKG_DESCRIPTION="Free, portable and lightweight Internet Relay Chat server"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="27"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/ngircd/ngircd/releases/download/rel-${CLANDRO_PKG_VERSION}/ngircd-${CLANDRO_PKG_VERSION%.*}.tar.xz"
CLANDRO_PKG_SHA256=6897880319dd5e2e73c1c9019613509f88eb5b8daa5821a36fbca3d785c247b8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="zlib, openssl"

# Termux does not use /sbin. Place the binary to $PATH/bin instead
# Also enable OpenSSL & IPv6 support
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--sbindir=$CLANDRO_PREFIX/bin
--with-openssl
--enable-ipv6
"

clandro_step_pre_configure() {
	sed -i.orig "s:endpwent ::g" "$CLANDRO_PKG_SRCDIR/configure"
}
