CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt X11 Extras enables the Qt programmer to write applications for the Linux/X11 platform"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.18"
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtx11extras-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=31e72bea959f9093bbc41023ab67f9d23bcf62c1f557064caa48b4c2f7709917
CLANDRO_PKG_DEPENDS="qt5-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

# Replacing the old qt5-base packages
CLANDRO_PKG_REPLACES="qt5-x11extras"

clandro_step_configure () {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"
}

clandro_step_make_install() {
	make install

	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5X11*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	## Remove *.la files.
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
}
