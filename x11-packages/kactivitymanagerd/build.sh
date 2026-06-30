CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kactivitymanagerd"
CLANDRO_PKG_DESCRIPTION="System service to manage user activities and track the usage patterns"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kactivitymanagerd-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=b405af0c48ad47ee4f2c70fd2a2aef9eee521120c15cac3f78945bd0e0fb3166
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, kf6-kcoreaddons, kf6-kcrash, kf6-kglobalaccel, kf6-ki18n, kf6-kio, kf6-kservice, kf6-kxmlgui, libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="boost, extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
