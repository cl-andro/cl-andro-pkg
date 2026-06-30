CLANDRO_PKG_HOMEPAGE=https://snowflake.torproject.org/
CLANDRO_PKG_DESCRIPTION="Pluggable Transport using WebRTC, inspired by Flashproxy"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.13.1"
CLANDRO_PKG_SRCURL=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/snowflake/-/archive/v${CLANDRO_PKG_VERSION}/snowflake-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3102c0782422205f6cea7609ab67cb5fd080e048880712ebe0c85540138cc09f
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	# https://github.com/termux/termux-packages/issues/22236
	# https://github.com/wlynxg/anet?tab=readme-ov-file#how-to-build-with-go-1230-or-later
	go build -ldflags=-checklinkname=0 -o snowflake-client $CLANDRO_PKG_SRCDIR/client/
	go build -ldflags=-checklinkname=0 -o snowflake-proxy $CLANDRO_PKG_SRCDIR/proxy/
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin snowflake-client
	install -Dm700 -t $CLANDRO_PREFIX/bin snowflake-proxy
}
