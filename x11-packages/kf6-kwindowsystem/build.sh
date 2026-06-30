CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kwindowsystem"
CLANDRO_PKG_DESCRIPTION="KDE Access to window manager"
CLANDRO_PKG_LICENSE="CC0-1.0, LGPL-2.1-only, LGPL-2.1-or-later, LGPL-3.0-only, LGPL-3.0-or-later, MIT"
CLANDRO_PKG_LICENSE_FILE="\
LICENSES/CC0-1.0.txt
LICENSES/LGPL-2.1-only.txt
LICENSES/LGPL-2.1-or-later.txt
LICENSES/LGPL-3.0-only.txt
LICENSES/LicenseRef-KDE-Accepted-LGPL.txt
LICENSES/MIT.txt"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kwindowsystem-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=5f7962b7c986e77c5d25fa4f7d09cd89144b8781e57ebc37fd45eaec1961bb02
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libwayland, libx11, libxcb, libxfixes, qt6-qtbase, qt6-qtdeclarative, xcb-util-keysyms"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), libwayland-protocols, plasma-wayland-protocols, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
