CLANDRO_PKG_HOMEPAGE=https://github.com/dflemstr/rq
CLANDRO_PKG_DESCRIPTION="A tool for doing record analysis and transformation"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.4
CLANDRO_PKG_REVISION=2
CLANDRO_PKG_SRCURL=https://github.com/dflemstr/rq/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4c3fc4427d02271c93a2cf4a784887982e97f9aba4946900aad1a35b142f9a47
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
