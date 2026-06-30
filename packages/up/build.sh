CLANDRO_PKG_HOMEPAGE=https://github.com/akavel/up
CLANDRO_PKG_DESCRIPTION="Helps interactively and incrementally explore textual data in Linux"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.4
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=git+https://github.com/akavel/up
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin up
}
