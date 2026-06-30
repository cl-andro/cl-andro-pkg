CLANDRO_PKG_HOMEPAGE=https://www.knot-dns.cz/
CLANDRO_PKG_DESCRIPTION="Knot DNS libraries"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.2.4
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://secure.nic.cz/files/knot-dns/knot-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=299e8de918f9fc7ecbe625b41cb085e47cdda542612efbd51cd5ec60deb9dd13
CLANDRO_PKG_DEPENDS="libgnutls, liblmdb"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-daemon
--disable-modules
--enable-utilities
"
