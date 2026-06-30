CLANDRO_PKG_HOMEPAGE=https://gohugo.io/
CLANDRO_PKG_DESCRIPTION="A fast and flexible static site generator"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.161.1"
CLANDRO_PKG_SRCURL=https://github.com/gohugoio/hugo/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=a429b730bdb0150a564de091a21fbb1bab8a63555768531077b8fbacc8d3742b
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libc++"

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	cd $CLANDRO_PKG_SRCDIR
	go build \
		-o "$CLANDRO_PREFIX/bin/hugo" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded

	# Building for host to generate manpages and completion.
	chmod 700 -R $GOPATH/pkg && rm -rf $GOPATH/pkg
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go build \
		-o "$CLANDRO_PKG_BUILDDIR/hugo" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/{bash-completion/completions,zsh/site-functions,fish/vendor_completions.d,man/man1}

	$CLANDRO_PKG_BUILDDIR/hugo completion bash > $CLANDRO_PREFIX/share/bash-completion/completions/hugo
	$CLANDRO_PKG_BUILDDIR/hugo completion zsh > $CLANDRO_PREFIX/share/zsh/site-functions/_hugo
	$CLANDRO_PKG_BUILDDIR/hugo completion fish > $CLANDRO_PREFIX/share/fish/vendor_completions.d/hugo.fish

	$CLANDRO_PKG_BUILDDIR/hugo gen man \
		--dir=$CLANDRO_PREFIX/share/man/man1/
}
