CLANDRO_PKG_HOMEPAGE=https://github.com/ginuerzh/gost
CLANDRO_PKG_DESCRIPTION="GO Simple Tunnel - a simple tunnel written in golang"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@ian4hu"
CLANDRO_PKG_VERSION="2.12.0"
CLANDRO_PKG_SRCURL=https://github.com/ginuerzh/gost/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=ed575807b0490411670556d4471338f418c326bb1ffe25f52977735012851765
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	go mod tidy

	go build --ldflags="-s -w" -a -o bin/gost cmd/gost/*.go
}

clandro_step_make_install() {
	install -Dm700 \
		"$CLANDRO_PKG_BUILDDIR/bin/gost" \
		"$CLANDRO_PREFIX/bin/"
}
