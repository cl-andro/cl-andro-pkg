CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/frameworks/kauth"
CLANDRO_PKG_DESCRIPTION="Framework which lets applications perform actions as a privileged user (KDE)"
CLANDRO_PKG_LICENSE="LGPL-2.1"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kauth-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=e6b6562114c2cb71db6ca48fdf0ebed2df70e164c48295b35433a80b03385847
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*})"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
