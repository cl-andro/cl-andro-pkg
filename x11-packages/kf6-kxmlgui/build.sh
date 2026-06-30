CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kxmlgui'
CLANDRO_PKG_DESCRIPTION='User configurable main windows'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kxmlgui-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=4383855cea5a7f9a269c72dda15490b8d70c1d23d17950963937332fc5d6b7a0
CLANDRO_PKG_DEPENDS="kf6-kcolorscheme (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfigwidgets (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kglobalaccel (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kguiaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kiconthemes (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kitemviews (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwidgetsaddons (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
