CLANDRO_PKG_HOMEPAGE=https://github.com/max-niederman/ttyper
CLANDRO_PKG_DESCRIPTION="Terminal-based typing test"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/max-niederman/ttyper/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f7e4ff2f803483b17f35aa0c02977326a0546a95f5b465b4dd34ff17e45b4021
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
