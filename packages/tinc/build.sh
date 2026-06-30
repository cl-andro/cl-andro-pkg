# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://www.tinc-vpn.org/
CLANDRO_PKG_DESCRIPTION="VPN daemon"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.36
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://www.tinc-vpn.org/packages/tinc-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=40f73bb3facc480effe0e771442a706ff0488edea7a5f2505d4ccb2aa8163108
CLANDRO_PKG_DEPENDS="liblzo, openssl, zlib"

clandro_step_pre_configure() {
	export LIBS="-llog"
}
