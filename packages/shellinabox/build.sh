CLANDRO_PKG_HOMEPAGE=https://github.com/shellinabox/shellinabox
CLANDRO_PKG_DESCRIPTION="Implementation of a web server that can export arbitrary command line tools to a web based terminal emulator"
# License: GPL-2.0-with-OpenSSL-exception
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.21
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/s/shellinabox/shellinabox_${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=4ec657182b3ec628c2a7b036b360011cef51a23104b2eb332eafede56528a632
CLANDRO_PKG_DEPENDS="openssl, openssl-tool, clandro-auth (>= 1.2), zlib"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--enable-login
--disable-pam
--disable-utmp
--disable-runtime-loading
"

clandro_step_pre_configure() {
	export LIBS="-lssl -lcrypto"
	autoreconf -i
}
