CLANDRO_PKG_HOMEPAGE=https://rakshasa.github.io/rtorrent/
CLANDRO_PKG_DESCRIPTION="Ncurses BitTorrent client based on libTorrent"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.16.11"
CLANDRO_PKG_SRCURL=https://github.com/rakshasa/rtorrent/releases/download/v${CLANDRO_PKG_VERSION}/rtorrent-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=bed2fefd69a01dbe95a02b330dd8c257d1aae2b4ee2ba4a9c4859da2fa404f65
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libcurl, libtorrent, libxmlrpc, ncurses"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--with-xmlrpc-c
"
