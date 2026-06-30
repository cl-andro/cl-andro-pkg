CLANDRO_PKG_HOMEPAGE=https://h3geo.org/
CLANDRO_PKG_DESCRIPTION="A hexagonal hierarchical geospatial indexing system"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.4.1"
CLANDRO_PKG_SRCURL=https://github.com/uber/h3/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9df719eb878f218c203e424dc5ffca9b98eca4d78ba83928773987649ead404d
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"

clandro_step_pre_configure() {
	LDFLAGS+=" -lm"
}
