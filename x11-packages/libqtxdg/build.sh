CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="Qt implementation of freedesktop.org XDG specifications"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/libqtxdg/releases/download/${CLANDRO_PKG_VERSION}/libqtxdg-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=34d25949ae7b6275fb54da46187dd8ba41771600353405b15e53bdc90b9e287a
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtsvg, glib"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
# See plugin path in libqtxdg/src/xdgiconloader/plugin/CMakeLists.txt
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DQTXDGX_ICONENGINEPLUGIN_INSTALL_PATH=${CLANDRO_PREFIX}/lib/qt6/plugins/iconengines
"
