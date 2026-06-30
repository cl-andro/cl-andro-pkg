CLANDRO_PKG_HOMEPAGE=https://github.com/lnslbrty/ptunnel-ng
CLANDRO_PKG_DESCRIPTION="Tunnel TCP connections through ICMP"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.43"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/lnslbrty/ptunnel-ng/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f16acc94b5387e8d88f510971a82ce25dcf2d0d599718e7eefb0ee26494dd665
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	autoreconf -fi
}
