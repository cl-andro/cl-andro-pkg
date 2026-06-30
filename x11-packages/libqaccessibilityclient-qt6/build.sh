CLANDRO_PKG_HOMEPAGE="https://invent.kde.org/libraries/libqaccessibilityclient"
CLANDRO_PKG_DESCRIPTION="Helper library to make writing accessibility tools easier"
CLANDRO_PKG_LICENSE="LGPL-2.1-only, LGPL-3.0-only"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.0"
CLANDRO_PKG_SRCURL="https://download.kde.org/Attic/libqaccessibilityclient/libqaccessibilityclient-${CLANDRO_PKG_VERSION}.tar.xz"
CLANDRO_PKG_SHA256="4c50c448622dc9c5041ed10da7d87b3e4e71ccb49d4831a849211d423c5f5d33"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"
CLANDRO_PKG_BUILD_DEPENDS="extra-cmake-modules, qt6-qtbase"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_WITH_QT6=ON
"
