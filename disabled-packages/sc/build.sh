CLANDRO_PKG_HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/financial/spreadsheet/!INDEX.html"
CLANDRO_PKG_DESCRIPTION="A vi-like spreadsheet calculator"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=7.16
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=http://www.ibiblio.org/pub/Linux/apps/financial/spreadsheet/sc-$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=1997a00b6d82d189b65f6fd2a856a34992abc99e50d9ec463bbf1afb750d1765
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="SIMPLE=-DSIMPLE"

clandro_step_post_configure () {
	CFLAGS+=" -I$CLANDRO_PREFIX/include"
}
