CLANDRO_PKG_HOMEPAGE='https://invent.kde.org/graphics/kdegraphics-mobipocket'
CLANDRO_PKG_DESCRIPTION='A library to handle mobipocket files'
CLANDRO_PKG_LICENSE="GPL-2.0, LGPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL=https://download.kde.org/stable/release-service/${CLANDRO_PKG_VERSION}/src/kdegraphics-mobipocket-${CLANDRO_PKG_VERSION}.tar.xz
CLANDRO_PKG_SHA256=de353837314402f4983893226483a88a9026266b53ddf64b07ef234d149ff7bd
CLANDRO_PKG_DEPENDS="libc++, qt6-qt5compat, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DQT_MAJOR_VERSION=6
"
