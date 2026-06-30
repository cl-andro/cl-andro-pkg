CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/aurorae"
CLANDRO_PKG_DESCRIPTION="A themeable window decoration for KWin"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/aurorae-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=f7dbc82de06a53dd2c3ff54ae542351485cd5b27e071fada5bb7fc87911054f3
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="bash, kf6-kcmutils, kf6-kcolorscheme, kf6-kconfig, kf6-kcoreaddons, kdecoration, kf6-ki18n, kf6-kirigami, kf6-knewstuff, kf6-kpackage, kf6-ksvg, libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
