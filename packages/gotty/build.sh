CLANDRO_PKG_HOMEPAGE=https://github.com/sorenisanerd/gotty
CLANDRO_PKG_DESCRIPTION="Share your terminal as a web application"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/sorenisanerd/gotty/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=95425b43d071d5a2019ccf018ba4a124d1f1ddc56e90d723caf75995641175c1
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/yudai
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/yudai/gotty

	cd "$GOPATH"/src/github.com/yudai/gotty
	go mod init || go mod download
	#go mod tidy
	go build
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/yudai/gotty/gotty \
		"$CLANDRO_PREFIX"/bin/
}
