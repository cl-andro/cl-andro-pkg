CLANDRO_PKG_HOMEPAGE=https://stand-up-notes.org
CLANDRO_PKG_DESCRIPTION="A very simple note taking cli app"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION=1.0.0
CLANDRO_PKG_REVISION=3
CLANDRO_PKG_SRCURL=https://github.com/basbossink/sun/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=f0c90b8796caa66662dd82790449ca844708e20b39f7e81ef7f1cbce211d1412
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "${CLANDRO_PKG_BUILDDIR}"/src/github.com/basbossink/
	ln -sf "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/basbossink/sun

	cd "$GOPATH"/src/github.com/basbossink/sun
	go build -ldflags "-s -w -X main.Version=${CLANDRO_PKG_VERSION}" .
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin \
		${CLANDRO_PKG_BUILDDIR}/src/github.com/basbossink/sun/sun
}
