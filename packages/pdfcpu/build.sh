CLANDRO_PKG_HOMEPAGE="https://pdfcpu.io"
CLANDRO_PKG_DESCRIPTION="A PDF processor written in Go"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.12.0"
CLANDRO_PKG_SRCURL="https://github.com/pdfcpu/pdfcpu/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=5c39e754c465709ced7f62289a837a37808bf48f355b8ef4608cfa9d8e32536f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_make() {
	clandro_setup_golang
	cd "${CLANDRO_PKG_SRCDIR}/cmd/pdfcpu"
	go build
}

clandro_step_make_install() {
	install -Dm700 "${CLANDRO_PKG_SRCDIR}/cmd/pdfcpu/pdfcpu" \
		"$CLANDRO_PREFIX/bin/"
}
