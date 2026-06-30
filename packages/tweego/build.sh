CLANDRO_PKG_HOMEPAGE=https://bitbucket.org/tmedwards/tweego
CLANDRO_PKG_DESCRIPTION="A free command line compiler for Twine/Twee story formats"
CLANDRO_PKG_LICENSE="BSD"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=2.1.1
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL=https://github.com/tmedwards/tweego/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=f58991ff0b5b344ebebb5677b7c21209823fa6d179397af4a831e5ef05f28b02
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/tmedwards
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/tmedwards/tweego

	cd "$GOPATH"/src/github.com/tmedwards/tweego
	go get -d -v github.com/tmedwards/tweego
	go build
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/tmedwards/tweego/tweego \
		"$CLANDRO_PREFIX"/bin/
}
