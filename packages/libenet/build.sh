CLANDRO_PKG_HOMEPAGE=http://enet.bespin.org
CLANDRO_PKG_DESCRIPTION="ENet reliable UDP networking library"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@ravener"
CLANDRO_PKG_VERSION="1.3.18"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=http://enet.bespin.org/download/enet-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2a8a0c5360d68bb4fcd11f2e4c47c69976e8d2c85b109dd7d60b1181a4f85d36

clandro_step_pre_configure() {
	autoreconf -vfi
}
