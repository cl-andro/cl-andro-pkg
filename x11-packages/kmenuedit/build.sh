CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kmenuedit"
CLANDRO_PKG_DESCRIPTION="KDE menu editor"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kmenuedit-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=b098c176623e9d848e80c769c1857ba7309187e2704e53e56c5eff84dc89760f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kcompletion, kf6-kconfig, kf6-kconfigwidgets, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kglobalaccel, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-kitemviews, kf6-kservice, kf6-kwidgetsaddons, kf6-kwindowsystem, kf6-kxmlgui, kf6-sonnet, libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, kf6-kdoctools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_DOC=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"

clandro_step_pre_configure() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "false" ]]; then
		CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DKF6_HOST_TOOLING=$CLANDRO_PREFIX/opt/kf6/cross/lib/cmake/"
	fi
}
