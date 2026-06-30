CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt 5 Multimedia Library"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.15.18"
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtmultimedia-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4c77fb601d10fdffe4a4749f9008a969d778c3bb0e6734bda39e7f46cd11c38c
# qt5-qtdeclarative is not needed because quick widget requires OpenGL
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase, pulseaudio, openal-soft, gstreamer, gst-plugins-base, gst-plugins-bad"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_configure () {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross" \
		GST_VERSION=1.0 \
		INCLUDEPATH+="${CLANDRO_PREFIX}/include/gstreamer-1.0/" \
		INCLUDEPATH+="${CLANDRO_PREFIX}/include/glib-2.0/" \
		INCLUDEPATH+="${CLANDRO_PREFIX}/lib/glib-2.0/include"
}

clandro_step_make_install() {
	make install

	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
	find "${CLANDRO_PREFIX}/lib" -type f -name "libQt5Multimedia*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	## Remove *.la files.
	find "${CLANDRO_PREFIX}/lib" -iname \*.la -delete
}
