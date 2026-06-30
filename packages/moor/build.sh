CLANDRO_PKG_HOMEPAGE=https://github.com/walles/moor
CLANDRO_PKG_DESCRIPTION="A pager designed to just do the right thing without any configuration"
CLANDRO_PKG_LICENSE="BSD 2-Clause"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.13.0"
CLANDRO_PKG_SRCURL=https://github.com/walles/moor/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=238717993c9cb769aea69c9847a3d01ba60d30c46fd4ddfac9b4aaea0f0431af
CLANDRO_PKG_CONFLICTS="moar"
CLANDRO_PKG_REPLACES="moar"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang
	go build -trimpath -ldflags="-s -w -X main.versionString=${CLANDRO_PKG_VERSION}" ./cmd/moor
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}/bin" moor
	install -Dm600 -t "${CLANDRO_PREFIX}/share/man/man1" moor.1
}
