CLANDRO_PKG_HOMEPAGE=https://esbuild.github.io/
CLANDRO_PKG_DESCRIPTION="An extremely fast JavaScript bundler"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.28.0"
CLANDRO_PKG_SRCURL=https://github.com/evanw/esbuild/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7aae83b197db3fd695e6f378d30fd6cbddeb93e4b1057b2c41d36ecb1dfebbc2
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
}

clandro_step_make() {
	go build ./cmd/esbuild
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin esbuild
}
