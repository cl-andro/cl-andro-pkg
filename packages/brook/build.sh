CLANDRO_PKG_HOMEPAGE=https://github.com/txthinking/brook
CLANDRO_PKG_DESCRIPTION="A cross-platform strong encryption and not detectable proxy. Zero-Configuration."
CLANDRO_PKG_LICENSE="GPL-3.0"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="20260101.0"
CLANDRO_PKG_SRCURL=https://github.com/txthinking/brook/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=8ddba4ed9ae9d10928e169f8121c6791e0e3c2907fa27d6e0055fe434f6e700e
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/txthinking
	mkdir -p "$CLANDRO_PREFIX"/share/doc/brook
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/txthinking/brook
	cd "$GOPATH"/src/github.com/txthinking/brook/cli/brook
	go get -d -v
	go build -o brook
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "$GOPATH"/src/github.com/txthinking/brook/cli/brook/brook
	cp -r "$CLANDRO_PKG_SRCDIR"/docs/* "$CLANDRO_PREFIX"/share/doc/brook
}
