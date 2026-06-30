CLANDRO_PKG_HOMEPAGE=https://miniflux.app/
CLANDRO_PKG_DESCRIPTION="A minimalist and opinionated feed reader"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.2.19"
CLANDRO_PKG_SRCURL=https://github.com/miniflux/v2/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1c88cd40f5deff94aab9ac1722b7b0f358e473a5d0974cdd5ce258e3ac2113f0
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXTRA_MAKE_ARGS="VERSION=$CLANDRO_PKG_VERSION"

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin miniflux
	install -Dm600 -t $CLANDRO_PREFIX/share/man/man1 miniflux.1
}
