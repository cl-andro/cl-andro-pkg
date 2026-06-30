CLANDRO_PKG_HOMEPAGE="https://libnova.sourceforge.net"
CLANDRO_PKG_DESCRIPTION="A general purpose, double precision, Celestial Mechanics, Astrometry and Astrodynamics library"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.16
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://deb.debian.org/debian/pool/main/libn/libnova/libnova_${CLANDRO_PKG_VERSION}.orig.tar.xz
CLANDRO_PKG_SHA256=5dea5b29cba777ab8de4fd30cdfdbc1728fe1b3c573902270c1106bad55439a2
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf -fi
}
