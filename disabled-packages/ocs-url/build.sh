CLANDRO_PKG_HOMEPAGE=https://www.opendesktop.org/p/1136805/
CLANDRO_PKG_DESCRIPTION="An install helper program for items served via OpenCollaborationServices (ocs://)"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=3.1.0
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=git+https://www.opencode.net/dfn2/ocs-url
CLANDRO_PKG_GIT_BRANCH=release-${CLANDRO_PKG_VERSION}
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtdeclarative, qt5-qtsvg"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$CLANDRO_PREFIX
"

clandro_step_pre_configure() {
	./scripts/prepare
}

clandro_step_configure() {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross" \
		${CLANDRO_PKG_EXTRA_CONFIGURE_ARGS}
}

clandro_step_post_make_install() {
	install -Dm600 -t $CLANDRO_PREFIX/share/doc/$CLANDRO_PKG_NAME \
		$CLANDRO_PKG_SRCDIR/README.md
}
