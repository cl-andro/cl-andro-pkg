CLANDRO_PKG_HOMEPAGE=https://github.com/tsujan/Arqiver
CLANDRO_PKG_DESCRIPTION="A simple Qt archiver manager based on libarchive"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@Yisus7u7"
CLANDRO_PKG_VERSION="1.0.1"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/tsujan/Arqiver/releases/download/V${CLANDRO_PKG_VERSION}/Arqiver-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=03b388ca53d4b68b7e6716189a2a489e4135b2fbb653c8ae261b8edbbffd009d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtsvg"
CLANDRO_PKG_RECOMMENDS="bsdtar, gzip, hicolor-icon-theme"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qttools-cross-tools"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DENABLE_QT5=OFF"
