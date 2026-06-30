# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://mirrors.edge.kernel.org/pub/software/network/ethtool/
CLANDRO_PKG_DESCRIPTION="standard Linux utility for controlling network drivers and hardware, particularly for wired Ethernet devices"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="7.0"
CLANDRO_PKG_SRCURL="https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/snapshot/ethtool-$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=fb4b77f1e915e14a94f289bd1429ef5a68fe5e8eaaa28212d4f220eda5321b5e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libmnl"

clandro_step_pre_configure() {
	autoreconf -fi
}
