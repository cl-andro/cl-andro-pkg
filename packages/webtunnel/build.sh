CLANDRO_PKG_HOMEPAGE=https://torproject.org/
CLANDRO_PKG_DESCRIPTION="Pluggable Transport based on HTTP Upgrade(HTTPT)"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.0.4"
CLANDRO_PKG_SRCURL="https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/webtunnel/-/archive/v${CLANDRO_PKG_VERSION}/webtunnel-v${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=a72dcca2f1234685c738c5b5b545d6be6c9866b1b44f5608e837da7702162775
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	go build -ldflags=-checklinkname=0 -o webtunnel-client "$CLANDRO_PKG_SRCDIR/main/client/"
	go build -ldflags=-checklinkname=0 -o webtunnel-server "$CLANDRO_PKG_SRCDIR/main/server/"
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX/bin" webtunnel-client
	install -Dm700 -t "$CLANDRO_PREFIX/bin" webtunnel-server
}
