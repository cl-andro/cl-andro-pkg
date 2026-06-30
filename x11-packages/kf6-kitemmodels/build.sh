CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kitemmodels"
CLANDRO_PKG_DESCRIPTION="Set of item models extending the Qt model-view framework (KDE)"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kitemmodels-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=a996201062ff7d21f9db972debc2d9615762ddb0fd9da069a42b7fd7bba1e61d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
