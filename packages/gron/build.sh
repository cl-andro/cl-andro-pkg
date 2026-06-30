CLANDRO_PKG_HOMEPAGE=https://github.com/tomnomnom/gron
CLANDRO_PKG_DESCRIPTION="Transforms JSON into discrete assignments"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.7.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=git+https://github.com/tomnomnom/gron
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin gron
}
