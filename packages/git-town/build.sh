CLANDRO_PKG_HOMEPAGE="https://www.git-town.com"
CLANDRO_PKG_DESCRIPTION="Git branches made easy"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="22.2.0"
CLANDRO_PKG_SRCURL="https://github.com/git-town/git-town/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=93d9b599d14817eda971703aef3c7df409b051611ceda014ce175fbe42bf1d69
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_golang
}

clandro_step_make() {
	go get -v
	go build
}

clandro_step_make_install() {
	mkdir -p "${CLANDRO_PREFIX}/share/bash-completion/completions"
	mkdir -p "${CLANDRO_PREFIX}/share/fish/vendor_completions.d"
	mkdir -p "${CLANDRO_PREFIX}/share/zsh/site-functions"

	( # borrowed from packages/glow
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go run . completions  zsh > "${CLANDRO_PREFIX}/share/zsh/site-functions/_${CLANDRO_PKG_NAME}"
	go run . completions bash > "${CLANDRO_PREFIX}/share/bash-completion/completions/${CLANDRO_PKG_NAME}"
	go run . completions fish > "${CLANDRO_PREFIX}/share/fish/vendor_completions.d/${CLANDRO_PKG_NAME}.fish"
	install -Dm755 "$CLANDRO_PKG_SRCDIR/git-town" -t "$CLANDRO_PREFIX/bin"
	)
}
