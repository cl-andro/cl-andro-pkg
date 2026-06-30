CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt 5 WebChannel Library"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.18"
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtwebchannel-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=80d6c00c773e7ded828eb9d6d6d9b08d498307d99110dd229dc9b8b3ed0f142f
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtdeclarative, qt5-qtwebsockets"
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
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5WebChannel*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	## Remove *.la files.
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
}
