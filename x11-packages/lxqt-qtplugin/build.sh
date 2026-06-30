CLANDRO_PKG_HOMEPAGE=https://lxqt.github.io
CLANDRO_PKG_DESCRIPTION="LXQt platform integration plugin for Qt"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.4.0"
CLANDRO_PKG_SRCURL="https://github.com/lxqt/lxqt-qtplugin/releases/download/${CLANDRO_PKG_VERSION}/lxqt-qtplugin-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=8c36b572613ccb0e35d39e87c044ac07e115c2de85bbdb646ffe4533af788a45
CLANDRO_PKG_DEPENDS="libc++, libdbusmenu-lxqt, libfm-qt, libqtxdg, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-D_QT_PLUGINS_DIR=${CLANDRO_PREFIX}/lib/qt6/plugins
"
