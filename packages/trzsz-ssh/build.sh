CLANDRO_PKG_HOMEPAGE=https://trzsz.github.io/ssh
CLANDRO_PKG_DESCRIPTION="An openssh client alternative"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.25"
CLANDRO_PKG_SRCURL=https://github.com/trzsz/trzsz-ssh/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9a692854733333643b6108f68bed0239b266c461e15125781503d957c9b47842
CLANDRO_PKG_RECOMMENDS='trzsz-go'
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
