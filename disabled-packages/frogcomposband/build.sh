CLANDRO_PKG_HOMEPAGE=https://github.com/sulkasormi/frogcomposband/
CLANDRO_PKG_DESCRIPTION="Open world Angband variant with many additions"
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_SRCURL=git+https://github.com/sulkasormi/frogcomposband
CLANDRO_PKG_VERSION=7.1.salmiak
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--disable-x11 --bindir=$CLANDRO_PREFIX/bin --sysconfdir=$CLANDRO_PREFIX/share/frogcomposband"
CLANDRO_PKG_RM_AFTER_INSTALL="share/angband/xtra share/angband/icons"

clandro_step_pre_configure () {
	./autogen.sh
	perl -p -i -e 's|ncursesw5-config|ncursesw6-config|g' configure
}

clandro_step_post_make_install () {
	rm -Rf $CLANDRO_PREFIX/share/frogcomposband/fonts
}

clandro_step_install_license() {
	install -Dm600 $CLANDRO_PKG_BUILDER_DIR/LICENSE \
		$CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME/LICENSE
}
