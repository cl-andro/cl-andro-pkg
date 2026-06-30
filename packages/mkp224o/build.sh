CLANDRO_PKG_HOMEPAGE=https://github.com/cathugger/mkp224o
CLANDRO_PKG_DESCRIPTION="Generate vanity ed25519 (hidden service version 3) onion addresses"
CLANDRO_PKG_LICENSE="CC0-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.7.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/cathugger/mkp224o/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=e7bda8517206a1786d97c793a2b7ad91be88e73ed2e7d9aad986f3bd5e3fdb5e
CLANDRO_PKG_DEPENDS="libsodium"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	autoconf -f

	# configure scripts tries to get version from git, or this file:
	echo "v$CLANDRO_PKG_VERSION" > $CLANDRO_PKG_SRCDIR/version.txt
}

clandro_step_make_install() {
	install -m700 mkp224o $CLANDRO_PREFIX/bin/
}
