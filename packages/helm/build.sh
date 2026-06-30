CLANDRO_PKG_HOMEPAGE=https://helm.sh
CLANDRO_PKG_DESCRIPTION="Helm helps you manage Kubernetes applications"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="4.1.4"
CLANDRO_PKG_SRCURL=https://github.com/helm/helm/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=cc365ae17de9bd856972198f9c372f9fd2146852434ade3b3c96303b564cdb15
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	cd "$CLANDRO_PKG_SRCDIR"
	mkdir -p "${CLANDRO_PKG_BUILDDIR}/src/github.com/helm"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_BUILDDIR}/src/github.com/helm/helm"
	cd "${CLANDRO_PKG_BUILDDIR}/src/github.com/helm/helm"
	make
}

clandro_step_make_install() {
	install -Dm700 ${CLANDRO_PKG_BUILDDIR}/src/github.com/helm/helm/bin/helm \
		$CLANDRO_PREFIX/bin/helm
}
