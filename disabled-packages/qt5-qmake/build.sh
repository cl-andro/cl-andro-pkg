CLANDRO_PKG_HOMEPAGE=https://www.qt.io/
CLANDRO_PKG_DESCRIPTION="Qt 5 QMake"
CLANDRO_PKG_LICENSE="LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=5.15.5
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://download.qt.io/archive/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtbase-everywhere-opensource-src-${CLANDRO_PKG_VERSION}.tar.xz"
# CLANDRO_PKG_SHA256 is not used in termux-build-qmake.sh.
CLANDRO_PKG_SHA256=SKIP_CHECKSUM
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_DEPENDS="qt5-qtbase"
CLANDRO_PKG_BREAKS="qt5-qtbase (<< 5.15.7)"
CLANDRO_PKG_REPLACES="qt5-qtbase (<< 5.15.7)"

clandro_step_make_install() {
	## Unpacking prebuilt qmake from archive.
	cd "${CLANDRO_PKG_SRCDIR}" && {
		tar xf "${CLANDRO_PKG_BUILDER_DIR}/prebuilt.tar.xz"
		install \
			-Dm700 "${CLANDRO_PKG_SRCDIR}/bin/qmake-${CLANDRO_HOST_PLATFORM}" \
			"${CLANDRO_PREFIX}/bin/qmake"
	}
}
