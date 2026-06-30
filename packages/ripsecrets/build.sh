CLANDRO_PKG_HOMEPAGE="https://github.com/sirwart/ripsecrets"
CLANDRO_PKG_DESCRIPTION="A command-line tool to prevent committing secret keys into your source code"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.11"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/sirwart/ripsecrets/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=786c1b7555c1f9562d7eb3994d932445ab869791be65bc77b8bd1fbbae3890b8
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
