CLANDRO_PKG_HOMEPAGE=https://github.com/github/git-sizer
CLANDRO_PKG_DESCRIPTION="Compute various size metrics for a Git repository"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION=1.5.0
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/github/git-sizer/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=07a5ac5f30401a17d164a6be8d52d3d474ee9c3fb7f60fd83a617af9f7e902bb
CLANDRO_PKG_DEPENDS="git"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_CACHEDIR/go
	make
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin bin/git-sizer
}
