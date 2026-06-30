CLANDRO_PKG_HOMEPAGE="https://www.qt.io"
CLANDRO_PKG_DESCRIPTION="Provides access to position, satellite and area monitoring classes"
CLANDRO_PKG_LICENSE="GPL-3.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtpositioning-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=d61fd0985ede513ec34d2d1c1e92f383eb8eb46678ca9da805cf795cccb796e9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="geoclue, libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="qt6-qtdeclarative"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
