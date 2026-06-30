CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-sdk"
CLANDRO_PKG_DESCRIPTION="Applications useful for Plasma development"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma-sdk-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=b9a469bbca0250656c32e754989a85eb71f4e86e361bcdf831af2cc3b9266326
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-karchive, kf6-kcmutils, kf6-kcolorscheme, kf6-kcompletion, kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kdeclarative, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kirigami, kf6-kitemmodels, kf6-knewstuff, kf6-kpackage, kf6-ksvg, kf6-ktexteditor, kf6-kwidgetsaddons, libc++, libplasma, plasma5support, qt6-qt5compat, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
