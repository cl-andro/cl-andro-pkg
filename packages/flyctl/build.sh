CLANDRO_PKG_HOMEPAGE=https://fly.io
CLANDRO_PKG_DESCRIPTION="Command line tools for fly.io services"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.4.49"
CLANDRO_PKG_SRCURL=https://github.com/superfly/flyctl/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=4f567deaebf9ad4bd6d798a3cebbb0b7734d0d1514f1a1759964ea02048ef9ce
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_EXCLUDED_ARCHES="i686, arm"

clandro_step_post_get_source() {
	clandro_setup_golang
	go mod tidy
	go mod vendor
}

clandro_step_make() {
	go build -o bin/flyctl
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "$CLANDRO_PKG_SRCDIR/bin/flyctl"
}
