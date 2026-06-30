CLANDRO_PKG_HOMEPAGE=https://github.com/golang/tools
CLANDRO_PKG_DESCRIPTION="The official Go language server"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.21.1"
CLANDRO_PKG_SRCURL=https://github.com/golang/tools/archive/refs/tags/gopls/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=af211e00c3ffe44fdf2dd3efd557e580791e09f8dbb4284c917bd120bc3c8f9c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
CLANDRO_PKG_UPDATE_TAG_TYPE=latest-release-tag

clandro_step_make() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR/gopls" && \
	go build -o gopls
}

clandro_step_make_install() {
	install -Dm755 -t "$CLANDRO_PREFIX/bin" "$CLANDRO_PKG_SRCDIR/gopls/gopls"
}
