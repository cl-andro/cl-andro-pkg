CLANDRO_PKG_HOMEPAGE="https://think-async.com/Asio"
CLANDRO_PKG_DESCRIPTION="Cross-platform C++ library for network and low-level I/O programming"
CLANDRO_PKG_LICENSE="BSL-1.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.36.0"
CLANDRO_PKG_SRCURL="https://downloads.sourceforge.net/project/asio/asio/${CLANDRO_PKG_VERSION}%20%28Stable%29/asio-${CLANDRO_PKG_VERSION}.zip"
CLANDRO_PKG_SHA256=e4613701d74113dbc691f53aaf29266147b3d55249fa046c74a57a2c9ed2fb27
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers, openssl"
CLANDRO_PKG_PLATFORM_INDEPENDENT=true

clandro_step_pre_configure() {
	autoreconf -fi
}
