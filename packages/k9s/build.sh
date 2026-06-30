CLANDRO_PKG_HOMEPAGE=https://k9scli.io
CLANDRO_PKG_DESCRIPTION="Kubernetes CLI To Manage Your Clusters In Style!"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="0.50.18"
CLANDRO_PKG_SRCURL=https://github.com/derailed/k9s/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=4a438b4bc480c05ba6f78a1573ee7e1dad7956ef3e30912ae22c744cea031f96
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	local GOPKG="github.com/derailed/k9s"
	local GOLDFLAGS="-w -s -X ${GOPKG}/cmd.version=${CLANDRO_PKG_VERSION} -X ${GOPKG}/cmd.commit=${CLANDRO_PKG_VERSION}"
	cd "$CLANDRO_PKG_SRCDIR"
	mkdir -p "${CLANDRO_PKG_BUILDDIR}/src/github.com/derailed"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_BUILDDIR}/src/github.com/derailed/k9s"
	cd "${CLANDRO_PKG_BUILDDIR}/src/github.com/derailed/k9s"

	go get -d -v
	go build -ldflags "$GOLDFLAGS"
}

clandro_step_make_install() {
	install -Dm700 ${CLANDRO_PKG_BUILDDIR}/src/github.com/derailed/k9s/k9s \
		$CLANDRO_PREFIX/bin/k9s
}
