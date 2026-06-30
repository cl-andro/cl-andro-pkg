CLANDRO_PKG_HOMEPAGE=https://dtach.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="Emulates the detach feature of screen"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.9
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/dtach/dtach-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=32e9fd6923c553c443fab4ec9c1f95d83fa47b771e6e1dafb018c567291492f3

clandro_step_make_install() {
	install -Dm700 -t ${CLANDRO_PREFIX}/bin dtach
	install -Dm600 -t ${CLANDRO_PREFIX}/share/man/man1 ${CLANDRO_PKG_SRCDIR}/dtach.1
}
