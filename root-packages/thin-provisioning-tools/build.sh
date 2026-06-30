CLANDRO_PKG_HOMEPAGE=https://github.com/jthornber/thin-provisioning-tools
CLANDRO_PKG_DESCRIPTION="A suite of tools for manipulating the metadata of the dm-thin, dm-cache and dm-era device-mapper targets."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.9.0"
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL="https://github.com/jthornber/thin-provisioning-tools/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=a2508d9933ed8a3f6c8d302280d838d416668a1d914a83c4bd0fb01eaf0676e8
CLANDRO_PKG_DEPENDS="libexpat, libaio, boost"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="--with-optimisation=-O3"
CLANDRO_PKG_AUTO_UPDATE=false

clandro_step_pre_configure() {
	CFLAGS+=" -I$CLANDRO_PREFIX/include"
	CXXFLAGS+=" -I$CLANDRO_PREFIX/include"
	autoconf
}
