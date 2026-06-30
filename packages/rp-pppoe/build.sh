CLANDRO_PKG_HOMEPAGE=https://dianne.skoll.ca/projects/rp-pppoe/
CLANDRO_PKG_DESCRIPTION="A PPP-over-Ethernet redirector for pppd"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.0
CLANDRO_PKG_REVISION=1
#CLANDRO_PKG_SRCURL=https://dianne.skoll.ca/projects/rp-pppoe/download/rp-pppoe-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SRCURL=https://fossies.org/linux/misc/rp-pppoe-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=41ac34e5db4482f7a558780d3b897bdbb21fae3fef4645d2852c3c0c19d81cea
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
"

clandro_step_pre_configure() {
	CLANDRO_PKG_SRCDIR=$CLANDRO_PKG_SRCDIR/src
	CLANDRO_PKG_BUILDDIR=$CLANDRO_PKG_SRCDIR
}
