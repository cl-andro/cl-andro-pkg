CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/frameworks/kfilemetadata'
CLANDRO_PKG_DESCRIPTION='A library for extracting file metadata'
CLANDRO_PKG_LICENSE="LGPL-2.0, LGPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.26.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/stable/frameworks/${CLANDRO_PKG_VERSION%.*}/kfilemetadata-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=f75942b9a3d1be0b0910cd50a22c3c432ededdc506858c8d5511ddf5498051f2
CLANDRO_PKG_DEPENDS="attr, ebook-tools, exiv2, ffmpeg, kf6-karchive (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcodecs (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kconfig (>= ${CLANDRO_PKG_VERSION%.*}), kf6-kcoreaddons (>= ${CLANDRO_PKG_VERSION%.*}), kf6-ki18n (>= ${CLANDRO_PKG_VERSION%.*}), libc++, poppler-qt, qt6-qtbase, taglib"
CLANDRO_PKG_BUILD_DEPENDS="catdoc, extra-cmake-modules (>= ${CLANDRO_PKG_VERSION%.*}), kdegraphics-mobipocket, qt6-qttools"
CLANDRO_PKG_RECOMMENDS="catdoc, kdegraphics-mobipocket"
CLANDRO_PKG_AUTO_UPDATE=true
# libappimage can be added to CLANDRO_PKG_BUILD_DEPENDS and CLANDRO_PKG_RECOMMENDS when available
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DXATTR_INCLUDE_DIRS=$CLANDRO_PREFIX/include
-DXATTR_LIBRARIES=$CLANDRO_PREFIX/lib/libattr.so
-DKDE_INSTALL_QMLDIR=lib/qt6/qml
-DKDE_INSTALL_QTPLUGINDIR=lib/qt6/plugins
"
