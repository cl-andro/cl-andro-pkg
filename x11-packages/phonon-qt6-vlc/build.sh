CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/libraries/phonon-vlc"
CLANDRO_PKG_DESCRIPTION="Phonon VLC backend"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/phonon/phonon-backend-vlc/${CLANDRO_PKG_VERSION}/phonon-backend-vlc-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256="338479dc451e4b94b3ca5b578def741dcf82f5c626a2807d36235be2dce7c9a5"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, phonon-qt6, pulseaudio, qt6-qtbase, vlc-qt"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DPHONON_BUILD_QT5=OFF
-DPHONON_BUILD_QT6=ON
"
