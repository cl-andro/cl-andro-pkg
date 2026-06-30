CLANDRO_PKG_HOMEPAGE=http://a-nikolaev.github.io/curseofwar/
CLANDRO_PKG_DESCRIPTION="Fast-paced action strategy game focusing on high-level strategic planning"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.3.0
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/a-nikolaev/curseofwar/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=2a90204d95a9f29a0e5923f43e65188209dc8be9d9eb93576404e3f79b8a652b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="libc++, ncurses"
CLANDRO_PKG_GROUPS="games"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_POLICY_VERSION_MINIMUM=3.5
"

clandro_step_make_install () {
	mkdir -p $CLANDRO_PREFIX/share/man/man6
	cp curseofwar $CLANDRO_PREFIX/bin
	cp $CLANDRO_PKG_SRCDIR/curseofwar.6 $CLANDRO_PREFIX/share/man/man6
}
