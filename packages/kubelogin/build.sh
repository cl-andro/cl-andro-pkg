CLANDRO_PKG_HOMEPAGE=https://github.com/int128/kubelogin
CLANDRO_PKG_DESCRIPTION="A kubectl plugin for Kubernetes OpenID Connect (OIDC) authentication"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.36.1"
CLANDRO_PKG_SRCURL=https://github.com/int128/kubelogin/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=7569969b178f9f771a8e0238afb41665dcfd3250e30865aac08e0887bebf3b76
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	cd "$CLANDRO_PKG_SRCDIR"
	mkdir -p "${CLANDRO_PKG_BUILDDIR}/src/github.com/int128"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_BUILDDIR}/src/github.com/int128/kubelogin"
	cd "${CLANDRO_PKG_BUILDDIR}/src/github.com/int128/kubelogin"

	go build -o kubelogin -ldflags "-X main.version=${CLANDRO_PKG_VERSION}"
}

clandro_step_make_install() {
	install -Dm700 ${CLANDRO_PKG_BUILDDIR}/src/github.com/int128/kubelogin/kubelogin \
		$CLANDRO_PREFIX/bin/kubectl-oidc_login
}
