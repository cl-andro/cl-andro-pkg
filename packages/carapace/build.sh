CLANDRO_PKG_HOMEPAGE=https://carapace.sh/
CLANDRO_PKG_DESCRIPTION="Multi-shell multi-command argument completer"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1.6.5"
CLANDRO_PKG_SRCURL=https://github.com/carapace-sh/carapace-bin/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=b0d3f3d2c60acc48bce48d27810ca510388699ca1d5a4db2fd154a22797a601e
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	( # Do this in a subshell to not mess with the variables for the main build.
	# `go generate` needs to run on the host machine
	# so we borrow a trick from gh and glow's package builds
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS

	go generate ./cmd/carapace/...
	)
	go build -v -ldflags="-X main.version=v${CLANDRO_PKG_VERSION} -s -w" -tags release ./cmd/carapace
}

clandro_step_make_install() {
	install -Dm700 carapace "$CLANDRO_PREFIX/bin/carapace"
}
