CLANDRO_PKG_HOMEPAGE=https://github.com/mrjosh/helm-ls
CLANDRO_PKG_DESCRIPTION="Language server for Helm"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.5.4"
CLANDRO_PKG_SRCURL=https://github.com/mrjosh/helm-ls/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a8a5490084839af3506c85efcf603fbd71bb9ee37222bbd7817da1da3f054ab3
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_configure() {
	clandro_setup_golang

	export CGO_CPPFLAGS="${CPPFLAGS}"
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"
	export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw"
	export GOLDFLAGS="-linkmode=external"
}

clandro_step_make_install() {
	install -Dm700 -t "${CLANDRO_PREFIX}/bin" bin/helm_ls
}
