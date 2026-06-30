# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://github.com/linuxhw/hw-probe
CLANDRO_PKG_DESCRIPTION="Tool to probe for hardware and check its operability"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.6.6
CLANDRO_PKG_SRCURL=https://github.com/linuxhw/hw-probe/archive/refs/tags/$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=d8d31ed978095d0bd2ca7af51cfee8b97c97f7168ddb48a479a1632e1af84c7b
CLANDRO_PKG_DEPENDS="curl, hwinfo, net-tools, perl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	:
}

clandro_step_make_install() {
	install -Dm700 hw-probe.pl "$CLANDRO_PREFIX"/bin/hw-probe
}
