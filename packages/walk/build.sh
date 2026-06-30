CLANDRO_PKG_HOMEPAGE=https://github.com/antonmedv/walk
CLANDRO_PKG_DESCRIPTION="A terminal file manager"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.13.0"
CLANDRO_PKG_SRCURL=https://github.com/antonmedv/walk/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=9f62377438908757fcb2210bd08bf346391858f21d0ef664d7998abf635880cb
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

# Package was previously named as "llama".
CLANDRO_PKG_BREAKS="llama (<< 1.4.0-2)"
CLANDRO_PKG_REPLACES="llama (<< 1.4.0-2)"

clandro_step_make() {
	clandro_setup_golang

	go mod init || :
	go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin walk
}
