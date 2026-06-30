CLANDRO_PKG_HOMEPAGE=http://www.mirbsd.org/jupp.htm
CLANDRO_PKG_DESCRIPTION="User friendly full screen text editor"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.1jupp41
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://anna.lysator.liu.se/pub/void-ppc-sources/jupp-${CLANDRO_PKG_VERSION}/joe-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=7bb8ea8af519befefff93ec3c9e32108d7f2b83216c9bc7b01aef5098861c82f
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_CONFLICTS="joe"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dependency-tracking
--disable-getpwnam
--disable-termcap
--disable-termidx
--enable-sysconfjoesubdir=/jupp
"

clandro_step_post_get_source() {
	chmod +x "$CLANDRO_PKG_SRCDIR/configure"
}
