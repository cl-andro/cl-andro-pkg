CLANDRO_PKG_HOMEPAGE=https://github.com/go-acme/lego
CLANDRO_PKG_DESCRIPTION="Let's Encrypt/ACME client and library written in Go"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Izumi Sena Sora <info@unordinary.eu.org>"
CLANDRO_PKG_VERSION="4.35.2"
CLANDRO_PKG_SRCURL="https://github.com/go-acme/lego/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=0afa5397dff24643ab34773518063432ed939788435a16305c92f2090a899c3b
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	mkdir build
	go build -v \
		-ldflags "-X main.version=v${CLANDRO_PKG_VERSION}" \
		-o build \
		./cmd/...
}

clandro_step_make_install() {
	install -Dm700 "build/${CLANDRO_PKG_NAME}" "${CLANDRO_PREFIX}/bin"
}
