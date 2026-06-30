CLANDRO_PKG_HOMEPAGE="https://www.qt.io/"
CLANDRO_PKG_DESCRIPTION="Provides a way to display web content in a QML application"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="6.11.0"
CLANDRO_PKG_SRCURL="https://download.qt.io/official_releases/qt/${CLANDRO_PKG_VERSION%.*}/${CLANDRO_PKG_VERSION}/submodules/qtwebview-everywhere-src-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256=cb0eaed94a12d5f650863d346c423e9f4383dbce1d05866869c40118c6e8c4b3
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase, qt6-qtdeclarative, qt6-qtwebengine"
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
