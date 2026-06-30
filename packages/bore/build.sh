CLANDRO_PKG_HOMEPAGE=https://github.com/ekzhang/bore
CLANDRO_PKG_DESCRIPTION="Bore is a simple CLI tool for making tunnels to localhost"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.6.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/ekzhang/bore/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=ab3175a6f304c7efdcacd0f6a0e4950f49eb31cb2a3ae9b4928c97ed8d03861c
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
