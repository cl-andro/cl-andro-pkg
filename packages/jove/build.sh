CLANDRO_PKG_HOMEPAGE=https://directory.fsf.org/wiki/Jove
CLANDRO_PKG_DESCRIPTION="Jove is a compact, powerful, Emacs-style text-editor."
CLANDRO_PKG_LICENSE="custom"
CLANDRO_PKG_LICENSE_FILE="LICENSE"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=4.17.5.3
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/jonmacs/jove/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ca5a5fcf71009c7389d655d1f1ae8139710f6cc531be95581e4b375e67f098d2
CLANDRO_PKG_DEPENDS="ncurses"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
JOVEHOME=$CLANDRO_PREFIX
SYSDEFS=-DLinux
LDLIBS=-lncursesw
"

clandro_step_post_massage() {
	mkdir -p ./var/lib/jove/preserve
}
