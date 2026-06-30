CLANDRO_PKG_HOMEPAGE=https://github.com/mypaint/mypaint-brushes
CLANDRO_PKG_DESCRIPTION="MyPaint brushes"
CLANDRO_PKG_LICENSE="CC0-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.0.2
CLANDRO_PKG_SRCURL=https://github.com/mypaint/mypaint-brushes/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=01032550dd817bb0f8e85d83a632ed2e50bc16e0735630839e6c508f02f800ac
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	autoreconf -fi
}
