CLANDRO_PKG_HOMEPAGE=https://github.com/asciimoo/wuzz
CLANDRO_PKG_DESCRIPTION="Interactive command line tool for HTTP inspection"
CLANDRO_PKG_LICENSE="AGPL-V3"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=0.5.0
CLANDRO_PKG_REVISION=5
CLANDRO_PKG_SRCURL=https://github.com/asciimoo/wuzz/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=721ea7343698e9f3c69e09eab86b9b1fef828057655f7cebc1de728c2f75151e
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/asciimoo
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/asciimoo/wuzz

	cd "$GOPATH"/src/github.com/asciimoo/wuzz
	go mod download github.com/BurntSushi/toml
	go get github.com/asciimoo/wuzz
	go build
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/asciimoo/wuzz/wuzz \
		"$CLANDRO_PREFIX"/bin/wuzz
}
