CLANDRO_PKG_HOMEPAGE=https://github.com/elves/elvish
CLANDRO_PKG_DESCRIPTION="A friendly and expressive Unix shell"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.21.0"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/elves/elvish/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=3a4b93c3c99fe2f9847de35d64be24e2d4b9c12d429cd9831b4571993a66bb7a
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/elves
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/elves/elvish

	cd "$GOPATH"/src/github.com/elves/elvish/cmd/elvish
	go build
}

clandro_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/elves/elvish/cmd/elvish/elvish \
		"$CLANDRO_PREFIX"/bin/elvish
}
