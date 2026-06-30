CLANDRO_PKG_HOMEPAGE=https://trzsz.github.io/
CLANDRO_PKG_DESCRIPTION="A simple file transfer tools, similar to lrzsz ( rz / sz )"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.2.0"
CLANDRO_PKG_SRCURL=https://github.com/trzsz/trzsz-go/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=6577fbab008264ff4678f60f56a0dea1e68763064a638eaf54e560198a5e6fd3
CLANDRO_PKG_RECOMMENDS='trzsz-ssh'
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="
BIN_DST=$CLANDRO_PREFIX/bin
"

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}
