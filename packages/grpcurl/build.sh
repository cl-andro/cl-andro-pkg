CLANDRO_PKG_HOMEPAGE=https://github.com/fullstorydev/grpcurl
CLANDRO_PKG_DESCRIPTION="Like cURL, but for gRPC: Command-line tool for interacting with gRPC servers"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.9.3"
CLANDRO_PKG_SRCURL="https://github.com/fullstorydev/grpcurl/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SHA256=bb555087f279af156159c86d4d3d5dd3f2991129e4cd6b09114e6851a679340d

clandro_step_make() {
	clandro_setup_golang
	export GOPATH="${CLANDRO_PKG_BUILDDIR}"

	cd "${CLANDRO_PKG_SRCDIR}"
	go build ./cmd/grpcurl
}

clandro_step_make_install() {
	install -Dm755 -t "${CLANDRO_PREFIX}/bin" \
		"${CLANDRO_PKG_SRCDIR}/grpcurl"
}
