CLANDRO_PKG_HOMEPAGE=https://pcal.sourceforge.net/
CLANDRO_PKG_DESCRIPTION="A multi-platform program which generates annotated PostScript or HTML calendars in a monthly or yearly format"
# The original calendar PostScript was Copyright (c) 1987 by Patrick Wood
# and Pipeline Associates, Inc. with permission to modify and redistribute.
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="doc/ReadMe.txt, COPYRIGHT.moonphase"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.11.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://downloads.sourceforge.net/pcal/pcal-${CLANDRO_PKG_VERSION}.tgz
CLANDRO_PKG_SHA256=8406190e7912082719262b71b63ee31a98face49aa52297db96cc0c970f8d207
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_post_get_source() {
	cp $CLANDRO_PKG_BUILDER_DIR/COPYRIGHT.moonphase ./
}

clandro_step_make() {
	make CC="$CC"
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin ./exec/pcal
	install -Dm700 -T ./doc/pcal.man $CLANDRO_PREFIX/share/man/man1/pcal.1
}
