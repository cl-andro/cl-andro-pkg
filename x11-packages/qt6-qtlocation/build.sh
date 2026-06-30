CLANDRO_PKG_HOMEPAGE="https://www.qt.io/"
CLANDRO_PKG_DESCRIPTION="Helps you create viable mapping solutions using the data available from some of the popular location services"
CLANDRO_PKG_LICENSE="GPL-3.0-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtlocation-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=89b8386a8ae9e0b40a43fad398ac344f93a3b0d22f09bec4631f25d79135abef
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative, qt6-qtpositioning"
CLANDRO_PKG_BUILD_DEPENDS="cmake, git, ninja"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
