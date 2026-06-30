CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kirigami'
CLANDRO_PKG_DESCRIPTION='A QtQuick based components set'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kirigami-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=b268785b271198acec7fe4b6177eafdee890e180245c7168916da3ccff1425ff
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-shadertools, qt6-qtsvg, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	LDFLAGS+=" -fopenmp -static-openmp"
}
