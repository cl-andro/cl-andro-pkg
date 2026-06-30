CLANDRO_PKG_HOMEPAGE=https://github.com/muesli/duf
CLANDRO_PKG_DESCRIPTION="Disk usage/free utility"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="0.9.1"
CLANDRO_PKG_SRCURL=https://github.com/muesli/duf/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1334d8c1a7957d0aceebe651e3af9e1c1e0c6f298f1feb39643dd0bd8ad1e955
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"

	mkdir -p "${CLANDRO_PKG_BUILDDIR}/src/github.com/muesli"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_BUILDDIR}/src/github.com/muesli/duf"
	cd "${CLANDRO_PKG_BUILDDIR}/src/github.com/muesli/duf"

	go get -d -v
	go build
}

clandro_step_make_install() {
	install -Dm700 ${CLANDRO_PKG_BUILDDIR}/src/github.com/muesli/duf/duf \
		$CLANDRO_PREFIX/bin/duf
	mkdir -p $CLANDRO_PREFIX/share/doc/duf

	install ${CLANDRO_PKG_BUILDDIR}/src/github.com/muesli/duf/README.md \
		$CLANDRO_PREFIX/share/doc/duf
}
