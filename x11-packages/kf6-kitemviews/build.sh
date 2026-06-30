CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kitemviews"
CLANDRO_PKG_DESCRIPTION="Set of item views extending the Qt model-view framework (KDE)"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kitemviews-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=e76cc9d7561d0aae22b07a77552fbcddf61c8066bac5cfac9958ac065b617e74
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
