CLANDRO_PKG_HOMEPAGE=http://www.cityinthesky.co.uk/opensource/pdf2svg/
CLANDRO_PKG_DESCRIPTION="A PDF to SVG converter"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.2.4"
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL="https://github.com/db9052/pdf2svg/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=fd765256f18b5890639e93cabdf631b640966ed1ea9ebd561aede9d3be2155e4
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="glib, libcairo, poppler"

clandro_step_pre_configure() {
	CXXFLAGS+=" -std=c++17"
}
