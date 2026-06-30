CLANDRO_PKG_HOMEPAGE="https://github.com/KDAB/KDSingleApplication"
CLANDRO_PKG_DESCRIPTION="KDAB's helper class for single-instance policy applications"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.1"
CLANDRO_PKG_SRCURL="https://github.com/KDAB/KDSingleApplication/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=e3254ce9dc5ecf6d61ef83264bc61d486a307f0e3c9ed1bb2176f068cdbcbe09
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, qt6-qtbase"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DKDSingleApplication_QT6=ON
"
