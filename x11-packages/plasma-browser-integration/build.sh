CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-browser-integration"
CLANDRO_PKG_DESCRIPTION="Components necessary to integrate browsers into the Plasma Desktop"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma-browser-integration-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=9ccc761b62f5ded99fe4a67b6e29e29e3b87f5794a8d08477bad41b92b7d6cb8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kdbusaddons, kf6-kfilemetadata, kf6-ki18n, kf6-kio, kf6-kjobwidgets, kf6-kservice, kf6-kstatusnotifieritem, kf6-purpose, libc++, plasma-activities, plasma-workspace, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
