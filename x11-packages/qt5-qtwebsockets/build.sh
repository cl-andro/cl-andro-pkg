CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt 5 WebSockets Library"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.18"
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtwebsockets-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=8cfc13d6465ab43717c508a90b6be15c5cec4952afb3b8c6e5192dabe83ec610
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_configure () {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"
}

clandro_step_post_make_install() {
	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
	sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "${CLANDRO_PREFIX}/lib/libQt5WebSockets.prl"

	## Remove *.la files.
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
}
