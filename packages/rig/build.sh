CLANDRO_PKG_HOMEPAGE=https://rig.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A program that generates fake identities"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.11
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/rig/rig/rig-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=00bfc970d5c038c1e68bc356c6aa6f9a12995914b7d4fda69897622cb5b77ab8
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin rig
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man6 rig.6
	install -Dm600 -t $CLANDRO_PREFIX/share/rig data/*.idx
}
