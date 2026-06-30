CLANDRO_PKG_HOMEPAGE=https://gitlab.torproject.org/tpo/core/torsocks
CLANDRO_PKG_DESCRIPTION="Wrapper to safely torify applications"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://gitlab.torproject.org/tpo/core/torsocks/-/archive/v${CLANDRO_PKG_VERSION}/torsocks-v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0fc8e18f2dc2e12f1129054f6d5acc7ecc3f0345bb57ed653fc8c6674e6ecc7e
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="tor"

clandro_step_pre_configure() {
	./autogen.sh
}
