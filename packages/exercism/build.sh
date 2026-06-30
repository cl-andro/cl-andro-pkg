CLANDRO_PKG_HOMEPAGE="https://github.com/exercism/cli/"
CLANDRO_PKG_DESCRIPTION="A Go based command line tool for exercism.io"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="3.5.8"
CLANDRO_PKG_SRCURL="https://github.com/exercism/cli/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=386cee0117c42a0ead45b6f636f96c2fc20cc5f64f802fcda93c7a0778330f3c
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR
	cd $CLANDRO_PKG_SRCDIR/exercism
	go build
}

clandro_step_post_make_install() {
	install -Dm700 "$CLANDRO_PKG_SRCDIR/exercism/exercism" \
		"$CLANDRO_PREFIX/bin/exercism"

	# shell completions
	install -Dm644 "$CLANDRO_PKG_SRCDIR/shell/exercism_completion.bash" \
		"$CLANDRO_PREFIX"/share/bash-completion/completions/exercism
	install -Dm644 "$CLANDRO_PKG_SRCDIR/shell/exercism_completion.zsh" \
		"$CLANDRO_PREFIX"/share/zsh/site-functions/_exercism
	install -Dm644 "$CLANDRO_PKG_SRCDIR/shell/exercism.fish" \
		"$CLANDRO_PREFIX"/share/fish/vendor_completions.d/exercism.fish
}
