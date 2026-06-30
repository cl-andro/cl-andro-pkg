CLANDRO_PKG_HOMEPAGE=https://github.com/dundee/gdu
CLANDRO_PKG_DESCRIPTION="Fast disk usage analyzer with console interface written in Go"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="5.34.4"
CLANDRO_PKG_SRCURL="https://github.com/dundee/gdu/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=81aef5ae5f0137794ae0385cd9b041a8772016ae9e19f5f071e17f187cbc6832
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_TAG_TYPE="newest-tag"

clandro_step_make() {
	clandro_setup_golang
	sed -i 's|CGO_ENABLED=0|CGO_ENABLED=1|g' Makefile

	make build VERSION="$CLANDRO_PKG_VERSION"
	make gdu.1
}

clandro_step_make_install() {
	install -D dist/gdu -t "$CLANDRO_PREFIX/bin"
	install -Dm644 gdu.1 -t "$CLANDRO_PREFIX/share/man/man1"
}
