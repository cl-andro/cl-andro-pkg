CLANDRO_PKG_HOMEPAGE=https://github.com/shenwei356/rush
CLANDRO_PKG_DESCRIPTION="A cross-platform command-line tool for executing jobs in parallel"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="0.9.0"
CLANDRO_PKG_SRCURL=https://github.com/shenwei356/rush/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=43ccc98c3c53b3995ee98fb1195ae3cdb7615c7fb8e4b2a6410c100733c764dc
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make_install() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"

	export GOPATH="${CLANDRO_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/shenwei356"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${GOPATH}/src/github.com/shenwei356/rush"
	cd "${GOPATH}/src/github.com/shenwei356/rush"
	go get -d -v
	go install

	install -Dm700 $CLANDRO_PKG_BUILDDIR/bin/*/rush $CLANDRO_PREFIX/bin/
}
