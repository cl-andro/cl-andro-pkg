CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/plasma-activities-stats"
CLANDRO_PKG_DESCRIPTION="Provides usage data for KDE activities"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/plasma-activities-stats-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=8b1a6a93afee6876d5050d874927912f32e52c60ff3c67bcded477f4f7c9cd45
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="kf6-kconfig, libc++, plasma-activities, qt6-qttools"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
