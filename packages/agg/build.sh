CLANDRO_PKG_HOMEPAGE="https://github.com/asciinema/agg"
CLANDRO_PKG_DESCRIPTION="asciinema gif generator"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.8.1"
CLANDRO_PKG_SRCURL="https://github.com/asciinema/agg/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=9a2a7e6ca2748befb6a4c1c3eff437ae6029fde99ec882a951b3671aa30eacdb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_RECOMMENDS="asciinema"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
