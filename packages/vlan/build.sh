# cl-andro (alamgir-zk) — ported from termux
CLANDRO_PKG_HOMEPAGE=https://salsa.debian.org/debian/vlan
CLANDRO_PKG_DESCRIPTION="ifupdown integration for vlan configuration"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.5
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/v/vlan/vlan_${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=ccf261839b79247be8dae93074e1c5fcbce3807787a0ff7aed4e1f7a9095c465
CLANDRO_PKG_DEPENDS="iproute2"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin vconfig
	local f
	for f in network/{if-post-down.d/vlan,if-pre-up.d/vlan,if-up.d/ip}; do
		install -Dm700 -T debian/${f} $CLANDRO_PREFIX/etc/${f}
	done
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man5 debian/vlan-interfaces.5
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man8 vconfig.8
}
