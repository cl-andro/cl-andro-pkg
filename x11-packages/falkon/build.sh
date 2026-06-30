CLANDRO_PKG_HOMEPAGE=https://www.falkon.org/
CLANDRO_PKG_DESCRIPTION="Cross-platform QtWebEngine Browser"
CLANDRO_PKG_LICENSE="GPL-2.0-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="26.04.1"
CLANDRO_PKG_SRCURL=https://download.kde.org/stable/release-service/$CLANDRO_PKG_VERSION/src/falkon-$CLANDRO_PKG_VERSION.tar.xz
CLANDRO_PKG_SHA256=d4c6e961b4d8e27d5cc670673d1a0571d953d22d35aee85857d567963f24d915
CLANDRO_PKG_DEPENDS="kf6-karchive, kf6-ki18n, qt6-qtbase, qt6-qtdeclarative, qt6-qtwebsockets, qt6-qtwebengine"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
# Qt6-Webengine doesn't support i686 on Termux.
CLANDRO_PKG_EXCLUDED_ARCHES="i686"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_BUILD_TYPE=Release
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_PYTHON_SUPPORT=OFF
"
