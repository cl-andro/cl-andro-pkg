CLANDRO_PKG_HOMEPAGE=https://sites.google.com/site/gogdownloader/
CLANDRO_PKG_DESCRIPTION="Open source downloader to GOG.com for Linux users using the same API as the official GOGDownloader"
CLANDRO_PKG_LICENSE="WTFPL"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.18"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/Sude-/lgogdownloader/releases/download/v${CLANDRO_PKG_VERSION}/lgogdownloader-${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=1974f09cb0e0cdfed536937335488548addd92e5c654f4229ac22594a22f8ae0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="boost, jsoncpp, libc++, libcurl, libhtmlcxx, libtinyxml2, rhash, tidy"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DHELP2MAN=OFF"

clandro_step_pre_configure() {
	# ld.lld: error: undefined symbol: Json::Value::operator[](char const*)
	CXXFLAGS+=" -DJSONCPP_HAS_STRING_VIEW=1"
}
