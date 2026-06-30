CLANDRO_PKG_HOMEPAGE=https://fcitx-im.org/
CLANDRO_PKG_DESCRIPTION="Configuration tool for Fcitx5"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.1.13"
CLANDRO_PKG_SRCURL=https://github.com/fcitx/fcitx5-configtool/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9e7d13da808cd6ce9fc9750ab882501013fca98f51c481ba1d7e8857fdb4d599
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"
CLANDRO_PKG_DEPENDS="fcitx5, fcitx5-qt, iso-codes, kf6-kdbusaddons, kf6-kitemviews, kf6-kwidgetsaddons, kf6-kwindowsystem, libc++, libx11, libxkbfile, qt6-qtbase, qt6-qtsvg, xkeyboard-config"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_TEST=OFF
-DENABLE_CONFIG_QT=ON
-DENABLE_KCM=OFF
-DUSE_QT6=ON
"
