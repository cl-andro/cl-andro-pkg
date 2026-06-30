CLANDRO_PKG_HOMEPAGE=https://roboticoverlords.org/orbiton/
CLANDRO_PKG_DESCRIPTION="Small, fast and limited text editor"
CLANDRO_PKG_LICENSE="BSD 3-Clause"
CLANDRO_PKG_MAINTAINER="Alexander F. Rødseth <xyproto@archlinux.org>"
CLANDRO_PKG_VERSION="2.73.1"
CLANDRO_PKG_SRCURL=https://github.com/xyproto/orbiton/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=e8096a71fb17c742f6259d56b606128e7e006a36452123c87a49e92e6d7219f9
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BREAKS="o, o-editor"
CLANDRO_PKG_REPLACES="o, o-editor"

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/xyproto
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/xyproto/o

	cd "$GOPATH"/src/github.com/xyproto/o/v2
	go build
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin \
		"$GOPATH"/src/github.com/xyproto/o/v2/orbiton
	ln -sfT orbiton "$CLANDRO_PREFIX"/bin/o
	install -Dm600 -t "$CLANDRO_PREFIX"/share/man/man1 \
		"$CLANDRO_PKG_SRCDIR"/o.1
}
