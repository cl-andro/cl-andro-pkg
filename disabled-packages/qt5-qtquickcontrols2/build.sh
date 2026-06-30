CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt Quick Controls2 module"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.14"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtquickcontrols2-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=25ee6bffabb63d9612e7f544e5e1cab5d1776fa49c47aa3c9a02eb56573ec982
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
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5QuickControls2*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5QuickTemplates2*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	## Remove *.la files.
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
}
