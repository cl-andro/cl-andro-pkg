CLANDRO_PKG_HOMEPAGE=https://invent.kde.org/frameworks/kimageformats
CLANDRO_PKG_DESCRIPTION="Image format plugins for KDE"
CLANDRO_PKG_LICENSE="LGPL-2.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kimageformats-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=c192552ee1831fd5e09af4e3633bb24726dfb4031170c4285024683bedaf9972
CLANDRO_PKG_DEPENDS="imath, kf6-karchive (>= ${CLANDRO_PKG_VERSION%.*}), libavif, libc++, libheif, libjxl, libraw, openjpeg, openexr"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), qt6-qttools"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
-DKIMAGEFORMATS_HEIF=ON
"
