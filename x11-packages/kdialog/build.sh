CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/utilities/kdialog"
CLANDRO_PKG_DESCRIPTION="A utility for displaying dialog boxes from shell scripts"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kdialog-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=64714ea3e68b207223e3867587966d6aff57f1e2ef282b1f09786c4f4244ae01
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kdbusaddons, kf6-kguiaddons, kf6-ki18n, kf6-kiconthemes, kf6-kio, kf6-ktextwidgets, kf6-kwidgetsaddons, kf6-kwindowsystem, libc++, libx11, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
