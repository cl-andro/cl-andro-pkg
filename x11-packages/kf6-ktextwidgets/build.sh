CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/ktextwidgets'
CLANDRO_PKG_DESCRIPTION='Advanced text editing widgets'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/ktextwidgets-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=6511f9909f90fac951e2873a44dd451b8ac71d38085a62c65a6fb5028e62d84d
CLANDRO_PKG_DEPENDS="kf6-kcolorscheme (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcompletion (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfigwidgets (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwidgetsaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-sonnet (>= ${CLANDRO_PKG_VERSION%.*}), libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_TEXT_TO_SPEECH=OFF
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
# qt6-qttexttospeech can be added to CLANDRO_PKG_DEPENDS when available, and -DWITH_TEXT_TO_SPEECH=OFF can be removed from CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
