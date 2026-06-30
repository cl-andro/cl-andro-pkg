CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/plasma/kpipewire"
CLANDRO_PKG_DESCRIPTION="Components relating to pipewire use in Plasma"
CLANDRO_PKG_LICENSE="LGPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.6.4"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/plasma/${CLANDRO_PKG_VERSION}/kpipewire-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=1b9ef2890be00ee96ca439770a3f7842f54ac901c6a47edd3d68aff85c1a3a8f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, ffmpeg, kf6-kcoreaddons, kf6-ki18n, libdrm, libepoxy, pipewire, libva, mesa, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
