CLANDRO_PKG_HOMEPAGE="https://apps.kde.org/spectacle/"
CLANDRO_PKG_DESCRIPTION="KDE screenshot capture utility"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/spectacle-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=1e6d66f3a4731c635f6abd144f1bb002271b12626ccb38e86f04e79c7e1ad2e6
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.[0-8].*"
CLANDRO_PKG_DEPENDS="libc++, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kglobalaccel, kf6-kguiaddons, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kjobwidgets, kf6-knotifications, kpipewire, kf6-kservice, kf6-kstatusnotifieritem, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, layer-shell-qt, libxcb, opencv, kf6-prison, kf6-purpose, kquickimageeditor, qt6-qtbase, qt6-qtdeclarative, qt6-qtimageformats, qt6-qtmultimedia, libwayland, xcb-util, xcb-util-cursor, xcb-util-image"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, plasma-wayland-protocols"
CLANDRO_PKG_RECOMMENDS="tesseract"
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
