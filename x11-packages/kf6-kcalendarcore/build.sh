CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kcalendarcore"
CLANDRO_PKG_DESCRIPTION="Library for Interfacing with Calendars"
CLANDRO_PKG_LICENSE="BSD 3-Clause, LGPL-2.0-or-later, LGPL-3.0-or-later"
CLANDRO_PKG_LICENSE_FILE="
LICENSES/BSD-3-Clause.txt
LICENSES/LGPL-2.0-or-later.txt
LICENSES/LGPL-3.0-or-later.txt
"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.25.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kcalendarcore-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d6a19c3ec0cdfc6979bfde08ce7c62db8c52dd9dff4a13e4da8978e00480dfeb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libical, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
