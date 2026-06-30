CLANDRO_PKG_HOMEPAGE=https://buf.build
CLANDRO_PKG_DESCRIPTION="A new way of working with Protocol Buffers"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.69.0"
CLANDRO_PKG_SRCURL=https://github.com/bufbuild/buf/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b5d662379d597a3010b9fde72d6102642d83b192b61138002a9a4a788e40806a
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	cd "$CLANDRO_PKG_SRCDIR"
	mkdir -p "${CLANDRO_PKG_BUILDDIR}/src/github.com/bufbuild"
	cp -a "${CLANDRO_PKG_SRCDIR}" "${CLANDRO_PKG_BUILDDIR}/src/github.com/bufbuild/buf"
	cd "${CLANDRO_PKG_BUILDDIR}/src/github.com/bufbuild/buf"

	go mod download
	go build -ldflags "-s -w" -trimpath ./cmd/buf
}

clandro_step_make_install() {
	install -Dm700 ${CLANDRO_PKG_BUILDDIR}/src/github.com/bufbuild/buf/buf \
		$CLANDRO_PREFIX/bin/buf
}
