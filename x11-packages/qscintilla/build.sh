CLANDRO_PKG_HOMEPAGE=https://riverbankcomputing.com/software/qscintilla
CLANDRO_PKG_DESCRIPTION="QScintilla is a port to Qt of the Scintilla editing component"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
# Align the version with `python-qscintilla` package.
CLANDRO_PKG_VERSION=2.14.1
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://www.riverbankcomputing.com/static/Downloads/QScintilla/${CLANDRO_PKG_VERSION}/QScintilla_src-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=dfe13c6acc9d85dfcba76ccc8061e71a223957a6c02f3c343b30a9d43a4cdd4d
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase"
# qttools is only needed to build Qt Designer's plugins
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools"
CLANDRO_PKG_BREAKS="python-qscintilla (<< ${CLANDRO_PKG_VERSION})"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="-C src"

clandro_step_configure () {
	for i in src designer; do
		cd "${CLANDRO_PKG_SRCDIR}/${i}" && {
			"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
				-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross"
		}
	done
	unset i
}

clandro_step_post_make_install() {
	cd "${CLANDRO_PKG_SRCDIR}/designer" && {
		make -j "${CLANDRO_PKG_MAKE_PROCESSES}"
		make install
	}
}
