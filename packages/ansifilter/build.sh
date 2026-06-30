CLANDRO_PKG_HOMEPAGE=http://www.andre-simon.de/doku/ansifilter/en/ansifilter.php
CLANDRO_PKG_DESCRIPTION="Strip or convert ANSI codes into HTML, (La)Tex, RTF, or BBCode"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.22"
CLANDRO_PKG_SRCURL=git+https://gitlab.com/saalen/ansifilter
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_GIT_BRANCH="$CLANDRO_PKG_VERSION"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_EXTRA_MAKE_ARGS="
DESTDIR=${CLANDRO_PREFIX}
PREFIX=
"

clandro_step_pre_configure() {
	# dont build Qt GUI
	rm $CLANDRO_PKG_SRCDIR/CMakeLists.txt
}
