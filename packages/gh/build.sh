CLANDRO_PKG_HOMEPAGE=https://cli.github.com/
CLANDRO_PKG_DESCRIPTION="GitHub’s official command line tool"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
CLANDRO_PKG_VERSION="2.92.0"
CLANDRO_PKG_SRCURL=https://github.com/cli/cli/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=ad18928ce4e2695d7fc1adefa0f5e0496e570a430016cee4c22d7bf87e5d9c1d
CLANDRO_PKG_RECOMMENDS="openssh"
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang

	cd "$CLANDRO_PKG_SRCDIR"
	(
		unset GOOS GOARCH CGO_LDFLAGS
		unset CC CXX CFLAGS CXXFLAGS LDFLAGS
		go run ./cmd/gen-docs --man-page --doc-path $CLANDRO_PREFIX/share/man/man1/
	)
	export GOPATH=$CLANDRO_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/cli/
	mkdir -p "$CLANDRO_PREFIX"/share/doc/gh
	cp -a "$CLANDRO_PKG_SRCDIR" "$GOPATH"/src/github.com/cli/cli
	cd "$GOPATH"/src/github.com/cli/cli/cmd/gh
	go get -d -v
	go build -ldflags="-X github.com/cli/cli/v${CLANDRO_PKG_VERSION%%.*}/internal/build.Version=$CLANDRO_PKG_VERSION"
}

clandro_step_make_install() {
	install -Dm700 -t "$CLANDRO_PREFIX"/bin "$GOPATH"/src/github.com/cli/cli/cmd/gh/gh

	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/gh.bash
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_gh
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/gh.fish
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		gh completion -s bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/gh.bash
		gh completion -s zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_gh
		gh completion -s fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/gh.fish
	EOF
}
