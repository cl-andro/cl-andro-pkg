CLANDRO_PKG_HOMEPAGE=https://github.com/mvdan/sh
CLANDRO_PKG_DESCRIPTION="A shell parser and formatter"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.13.1"
CLANDRO_PKG_SRCURL=https://github.com/mvdan/sh/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b31aad2d4c26b0c6e8ebe894d59022520bbebce33e082d7d29e4325eee35d308
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make_install() {
	cd "$CLANDRO_PKG_SRCDIR"

	clandro_setup_golang

	export GOPATH="$CLANDRO_PKG_BUILDDIR"
	mkdir -p "$GOPATH/src/github.com/mvdan"
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH/src/github.com/mvdan/sh"

	go build -modcacherw \
		-ldflags "-X main.version=$CLANDRO_PKG_VERSION" \
		-o "$CLANDRO_PREFIX/bin/shfmt" \
		./cmd/shfmt
}
