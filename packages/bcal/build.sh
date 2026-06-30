CLANDRO_PKG_HOMEPAGE=https://github.com/jarun/bcal
CLANDRO_PKG_DESCRIPTION="Command-line utility for storage conversions and calculations"
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.5"
CLANDRO_PKG_SRCURL="https://github.com/jarun/bcal/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=7e00d38aca2272ef93f55515841e2912ecf845914ec140f8e4c356e1493cf5cf
CLANDRO_PKG_DEPENDS="readline"
CLANDRO_PKG_BUILD_IN_SRC=true

# 64-bit archs only, check https://github.com/jarun/bcal/issues/4
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"
