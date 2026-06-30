CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/libraries/kquickimageeditor"
CLANDRO_PKG_DESCRIPTION="QML image editing components"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/kquickimageeditor/kquickimageeditor-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=b868800bb9bb814ee36c9d696be9ccec9a22ab6f975d789e248b75fbd1ba99fa
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kirigami, libc++, opencv, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DCMAKE_CXX_FLAGS=-I$CLANDRO_PREFIX/include/opencv4
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
