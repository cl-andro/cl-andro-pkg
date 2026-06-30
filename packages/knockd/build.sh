CLANDRO_PKG_HOMEPAGE=https://zeroflux.org/projects/knock
CLANDRO_PKG_DESCRIPTION="A port-knocking daemon"
CLANDRO_PKG_LICENSE="GPL-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.8.2"
CLANDRO_PKG_REVISION=2
# Original hasnt been maintained in a long time - use this fork instead - includes IPv6 support
CLANDRO_PKG_SRCURL=https://github.com/TDFKAOlli/knock/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a5814eac3d8337c64be88520300d56396256186522445e904ad51d14ba0e922f
CLANDRO_PKG_DEPENDS="libpcap"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	autoreconf -fi
}
