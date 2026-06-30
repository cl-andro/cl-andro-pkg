CLANDRO_PKG_HOMEPAGE=https://pcal.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A multi-platform program which generates PostScript lunar calendars in a yearly format"
# The original calendar PostScript was Copyright (c) 1987 by Patrick Wood
# and Pipeline Associates, Inc. with permission to modify and redistribute.
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="ReadMe.txt, COPYRIGHT.moonphase"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.1.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/pcal/lcal-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=c3c4c2bdec5f5129004385f06960f56bc0e3671ae835ee39044598fb76480f70
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/COPYRIGHT.moonphase ./
}

clandro_step_make() {
	make CC="$CC"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin ./lcal
	install -Dm700 -T ./lcal.man $CLANDRO_PREFIX/share/man/man1/lcal.1
}
