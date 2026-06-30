CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kcrash'
CLANDRO_PKG_DESCRIPTION='Support for application crash analysis and bug report from apps'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kcrash-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d05d93863a745ce0d4ab8ccff684a84a813ee4cbcc68c9c7a5175107b107e931
CLANDRO_PKG_DEPENDS="kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), libc++, libx11, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
# CLANDRO_PKG_RECOMMENDS="drkonqi"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
