CLANDRO_PKG_HOMEPAGE="https://github.com/file-acomplaint/simuwaerm"
CLANDRO_PKG_DESCRIPTION="A simple heat transfer simulator in pure Rust"
CLANDRO_PKG_GROUPS="science"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.02"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL="https://github.com/file-acomplaint/simuwaerm/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=cf3d86e9883e917b9c74ff3d1fc9146197b216b5aa84e84cc188326c8d922ac0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust
}
