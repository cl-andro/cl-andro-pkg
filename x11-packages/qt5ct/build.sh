CLANDRO_PKG_HOMEPAGE=https://sourceforge.net/projects/qt5ct/
CLANDRO_PKG_DESCRIPTION="Qt5 Configuration Tool"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://downloads.sf.net/qt5ct/qt5ct-${CLANDRO_PKG_VERSION}.tar.bz2"
CLANDRO_PKG_SHA256=dc10e6939d423b925981ce67febb1a015b6f61c022a9cc7e6c8b5efea4588bff
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt5-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_NO_STATICSPLIT=true

clandro_step_configure () {
	"${CLANDRO_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${CLANDRO_PREFIX}/lib/qt/mkspecs/termux-cross" \
		PREFIX="${CLANDRO_PREFIX}"
}
