CLANDRO_PKG_HOMEPAGE=https://libtins.github.io
CLANDRO_PKG_DESCRIPTION="High-level, multiplatform C++ network packet sniffing and crafting library."
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.5"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/mfontanini/libtins/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=6ff5fe1ada10daef8538743dccb9c9b3e19d05d028ffdc24838e62ff3fc55841
TRRMUX_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++, libpcap, openssl"
CLANDRO_PKG_BUILD_DEPENDS="boost, boost-headers"
CLANDRO_PKG_BREAKS="libtins-dev"
CLANDRO_PKG_REPLACES="libtins-dev"
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
