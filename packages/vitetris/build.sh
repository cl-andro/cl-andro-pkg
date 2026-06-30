CLANDRO_PKG_HOMEPAGE=http://victornils.net/tetris/
CLANDRO_PKG_DESCRIPTION="Virtual terminal *tris clone"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_LICENSE_FILE="licence.txt"
CLANDRO_PKG_VERSION=0.59.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/vicgeralds/vitetris/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=699443df03c8d4bf2051838c1015da72039bbbdd0ab0eede891c59c840bdf58d
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_RM_AFTER_INSTALL="share/applications/vitetris.desktop share/pixmaps"
CLANDRO_PKG_GROUPS="games"

clandro_step_configure() {
	"$CLANDRO_PKG_SRCDIR/configure" \
		--prefix=$CLANDRO_PREFIX \
		$CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
}
