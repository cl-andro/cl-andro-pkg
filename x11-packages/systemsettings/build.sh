CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/systemsettings"
CLANDRO_PKG_DESCRIPTION="KDE system manager for hardware, software, and workspaces"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/systemsettings-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=18d2aab42f3f3ce17c5e636238c2d7a1908152f2203f521d6d8441537d3edf04
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kauth, kf6-kcmutils, kf6-kcolorscheme, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-ki18n, kf6-kio, kf6-kirigami, kf6-kitemmodels, kf6-kitemviews, kf6-kjobwidgets, kf6-krunner, kf6-kservice, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, libc++, plasma-activities, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, ibus, intltool, kf6-kdoctools, libwayland-protocols"
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
