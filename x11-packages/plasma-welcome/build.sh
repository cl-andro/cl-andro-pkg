CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-welcome"
CLANDRO_PKG_DESCRIPTION="A friendly onboarding wizard for Plasma"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma-welcome-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=f05c53bae317e482fbb141bb61a8ad868b08a93f625599c2289cdfb0b79c1fba
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcmutils, kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kjobwidgets, kf6-knewstuff, kf6-kservice, kf6-ksvg, kf6-kuserfeedback, kf6-kwindowsystem, kirigami-addons, libc++, libplasma, plasma5support, qt6-qt5compat, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
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
