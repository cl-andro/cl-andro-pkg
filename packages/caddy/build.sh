CLANDRO_PKG_HOMEPAGE=https://caddyserver.com/
CLANDRO_PKG_DESCRIPTION="Fast, cross-platform HTTP/2 web server"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.11.2"
CLANDRO_PKG_SRCURL=https://github.com/caddyserver/caddy/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=ee12f7b5f97308708de5067deebb3d3322fc24f6d54f906a47a0a4e8db799122
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	mkdir -p $GOPATH/src/github.com/caddyserver/
	cp -a $CLANDRO_PKG_SRCDIR $GOPATH/src/github.com/caddyserver/caddy

	cd $GOPATH/src/github.com/caddyserver/caddy/cmd/caddy
	export GO111MODULE=on
	go build -v .
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin $GOPATH/src/github.com/caddyserver/caddy/cmd/caddy/caddy
}
