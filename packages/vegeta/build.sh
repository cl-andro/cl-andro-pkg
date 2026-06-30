CLANDRO_PKG_HOMEPAGE=https://github.com/tsenart/vegeta
CLANDRO_PKG_DESCRIPTION="HTTP load testing tool"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="12.13.0"
CLANDRO_PKG_SRCURL=https://github.com/tsenart/vegeta/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4a360c815f5a8bdcae6db184860788696bb1c63d6999cc676e47690fc8b659e5
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/tsenart
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/tsenart/vegeta

	cd "$GOPATH"/src/github.com/tsenart/vegeta
	go build
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/tsenart/vegeta/vegeta \
		"$CLANDRO_PREFIX"/bin/vegeta
}
