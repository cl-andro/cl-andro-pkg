CLANDRO_PKG_HOMEPAGE=https://invent.kde.org/plasma/layer-shell-qt
CLANDRO_PKG_DESCRIPTION="Qt component to allow applications to make use of the Wayland wl-layer-shell protocol"
CLANDRO_PKG_LICENSE="LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL=https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/layer-shell-qt-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=731af7a222bc1a1e87fd993060ed8fa515b4b38cbc294063b700ec87451e013f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative, libwayland"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, libwayland-cross-scanner, libwayland-protocols"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	clandro_setup_wayland_cross_pkg_config_wrapper
}
