CLANDRO_PKG_HOMEPAGE="https://api.kde.org/legacy/futuresql/html/index.html"
CLANDRO_PKG_DESCRIPTION="Non-blocking Qt database framework"
CLANDRO_PKG_LICENSE="LGPL-2.1-or-later"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.1"
CLANDRO_PKG_SRCURL="https://download.kde.org/Attic/futuresql/futuresql-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256="e44ed8d5a9618b3ca7ba2983ed9c5f7572e6e0a5b199f94868834b71ccbebd43"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_WITH_QT6=ON
"
