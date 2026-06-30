CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/myman/
CLANDRO_PKG_DESCRIPTION="Video game for color and monochrome text terminals in the genre of Namco's Pac-Man"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Henrik Grimler @Grimler91"
CLANDRO_PKG_VERSION=0.7.1
CLANDRO_PKG_REVISION=6
CLANDRO_PKG_SRCURL=https://sourceforge.net/projects/myman/files/myman-cvs/myman-cvs-2009-10-30/myman-cvs-2009-10-30.tar.gz
CLANDRO_PKG_SHA256=253e22f26dc95c63388bc4cb81075a05f77f7709d1d64ed9fde7aae38a7fc962
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_HOSTBUILD=true
# myman is installed twice for no reason
CLANDRO_PKG_RM_AFTER_INSTALL="bin/myman-$CLANDRO_PKG_VERSION"
CLANDRO_PKG_GROUPS="games"

clandro_step_get_source() {
	cd $CLANDRO_PKG_CACHEDIR
	clandro_download "${CLANDRO_PKG_SRCURL}" "$(basename ${CLANDRO_PKG_SRCURL})" "${CLANDRO_PKG_SHA256}"
	tar -xf "$(basename ${CLANDRO_PKG_SRCURL})"
	mkdir -p $CLANDRO_PKG_SRCDIR
	cd $CLANDRO_PKG_SRCDIR
	cvs -d$CLANDRO_PKG_CACHEDIR/myman-cvs co -P myman
	mv myman/* .
}

clandro_step_host_build() {
	$CLANDRO_PKG_SRCDIR/configure
	make obj/s1game
}

clandro_step_post_configure() {
	mkdir -p obj
	cp $CLANDRO_PKG_HOSTBUILD_DIR/obj/s1game obj/
	touch -d "next hour" obj/s1game
}
