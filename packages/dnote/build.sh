CLANDRO_PKG_HOMEPAGE=https://www.getdnote.com/
CLANDRO_PKG_DESCRIPTION="A simple command line notebook for programmers"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="Ravener <ravener.anime@gmail.com>"
CLANDRO_PKG_VERSION="1:0.16.0"
CLANDRO_PKG_SRCURL="https://github.com/dnote/dnote/archive/refs/tags/cli-v${CLANDRO_PKG_VERSION:2}.tar.gz"
CLANDRO_PKG_SHA256=fb63c6099ca441a2027a9e8ae2a3c38376e5c0950bef9e8028b96ca2b8b6427f
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP="cli-v\d+\.\d+\.\d+(?!-)"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_BREAKS=dnote-client
CLANDRO_PKG_REPLACES=dnote-client

clandro_step_pre_configure() {
	clandro_setup_golang
	go mod download
}

clandro_step_make() {
	cd "$CLANDRO_PKG_SRCDIR"
	go build -o dnote -ldflags "-X main.versionTag=${CLANDRO_PKG_VERSION:2}" -tags fts5 pkg/cli/main.go
}

clandro_step_make_install() {
	install -Dm700 $CLANDRO_PKG_SRCDIR/dnote $CLANDRO_PREFIX/bin/dnote
	install -Dm600 "$CLANDRO_PKG_SRCDIR"/pkg/cli/dnote-completion.bash \
		"$CLANDRO_PREFIX"/share/bash-completion/completions/dnote
	install -Dm600 "$CLANDRO_PKG_SRCDIR"/pkg/cli/dnote-completion.zsh \
		"$CLANDRO_PREFIX"/share/zsh/site-functions/_dnote
}
