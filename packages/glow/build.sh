CLANDRO_PKG_HOMEPAGE=https://github.com/charmbracelet/glow
CLANDRO_PKG_DESCRIPTION="Render markdown on the CLI, with pizzazz!"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.1.2"
CLANDRO_PKG_SRCURL=https://github.com/charmbracelet/glow/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=1b933139da1d08647bf5b3f112cab9548fdc2b40c056c7fa3d84d8706de5265a
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_SUGGESTS=git

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	mkdir -p "${CLANDRO_PKG_BUILDDIR}/src/github.com/charmbracelet"

	go get -v
	go build
}

clandro_step_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/share/man/man1"
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"

	# borrowed from packages/gh
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go run .             man > "${CLANDRO_PREFIX}/share/man/man1/${CLANDRO_PKG_NAME}.1"
	go run . completion  zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	go run . completion bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	go run . completion fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	install -Dm700 glow "$CLANDRO_PREFIX/bin/glow"
}
