CLANDRO_PKG_HOMEPAGE=https://github.com/ambrop72/badvpn
CLANDRO_PKG_DESCRIPTION="UDP gateway for BadVPN"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.999.130
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/ambrop72/badvpn/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=bfd4bbfebd7274bcec792558c9a2fd60e39cd92e04673825ade5d04154766109

clandro_step_configure() {
	:
}

clandro_step_make() {
	SRCDIR="$CLANDRO_PKG_SRCDIR" ENDIAN=little KERNEL=2.4 \
		bash "$CLANDRO_PKG_SRCDIR/compile-udpgw.sh"
}

clandro_step_make_install() {
	install -Dm700 -T udpgw $CLANDRO_PREFIX/bin/badvpn-udpgw
}
