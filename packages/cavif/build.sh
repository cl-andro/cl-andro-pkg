CLANDRO_PKG_HOMEPAGE="https://lib.rs/cavif"
CLANDRO_PKG_DESCRIPTION="AVIF image creator in pure Rust"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.5.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/kornelski/cavif-rs/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=a5ddb99a10d052e2ccb2999eb9e7ddf37f999f03e2b684744f5ca69cdef2e814
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BREAKS="cavif-rs"
CLANDRO_PKG_REPLACES="cavif-rs"

clandro_step_pre_configure() {
	clandro_setup_rust
}
