CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kwallet'
CLANDRO_PKG_DESCRIPTION='Secure and unified container for user passwords'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.25.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kwallet-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=6fe7c8f4c556db4861f0046dfe179c31e7891fb6ecdcfa33692d252bf23d3b11
CLANDRO_PKG_DEPENDS="gpgme, gpgmepp, kf6-kcolorscheme (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcrash (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kdbusaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), kf6-knotifications (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwidgetsaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kwindowsystem (>= ${CLANDRO_PKG_VERSION%.*}), libc++, libgcrypt, libsecret, qca, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kservice (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_RECOMMENDS="kwalletmanager"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
