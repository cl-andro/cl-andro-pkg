CLANDRO_PKG_HOMEPAGE=https://www.gnu.org/software/gnugo/
CLANDRO_PKG_DESCRIPTION="Program that plays the game of Go"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.8
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnugo/gnugo-${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72
CLANDRO_PKG_DEPENDS="ncurses, readline"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-readline"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_GROUPS="games"

clandro_step_post_configure () {
	cp $CLANDRO_PKG_HOSTBUILD_DIR/patterns/mkeyes $CLANDRO_PKG_BUILDDIR/patterns/mkeyes
	cp $CLANDRO_PKG_HOSTBUILD_DIR/patterns/uncompress_fuseki $CLANDRO_PKG_BUILDDIR/patterns/uncompress_fuseki
	cp $CLANDRO_PKG_HOSTBUILD_DIR/patterns/joseki $CLANDRO_PKG_BUILDDIR/patterns/joseki
	cp $CLANDRO_PKG_HOSTBUILD_DIR/patterns/mkmcpat $CLANDRO_PKG_BUILDDIR/patterns/mkmcpat
	cp $CLANDRO_PKG_HOSTBUILD_DIR/patterns/mkpat $CLANDRO_PKG_BUILDDIR/patterns/mkpat
	touch -d "next hour" $CLANDRO_PKG_BUILDDIR/patterns/*
}
