CLANDRO_PKG_HOMEPAGE=https://github.com/go-delve/delve
CLANDRO_PKG_DESCRIPTION="A debugger for the Go programming language"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="1.26.3"
CLANDRO_PKG_DEPENDS="golang, git"
CLANDRO_PKG_SRCURL=https://github.com/go-delve/delve/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=c5abd02033d7601a41bb6748589c0be42080dc4f91c7e48fc8cbb7f558cc8748
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_make() {
	clandro_setup_golang
	cd $CLANDRO_PKG_SRCDIR

	mkdir -p "$CLANDRO_PKG_BUILDDIR"/src/github.com/go-delve/
	mkdir -p "$CLANDRO_PREFIX"/share/doc/delve
	cp -a "$CLANDRO_PKG_SRCDIR" "$CLANDRO_PKG_BUILDDIR"/src/github.com/go-delve/delve/
	cd "$CLANDRO_PKG_BUILDDIR"/src/github.com/go-delve/delve/cmd/dlv/
	go get -d -v
	go build
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "$CLANDRO_PKG_BUILDDIR"/src/github.com/go-delve/delve/cmd/dlv/dlv
	cp -a "$CLANDRO_PKG_SRCDIR"/Documentation/* "$CLANDRO_PREFIX"/share/doc/delve
}
