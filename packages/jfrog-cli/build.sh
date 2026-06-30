CLANDRO_PKG_HOMEPAGE=https://jfrog.com/getcli
CLANDRO_PKG_DESCRIPTION="A CLI for JFrog products"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.103.0"
CLANDRO_PKG_SRCURL=https://github.com/jfrog/jfrog-cli/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=909d1761782a3870801662d54e25ffd8cc4028e5bb6b3a095e2bc1ae8024e971
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_BUILDDIR

	cd $CLANDRO_PKG_SRCDIR
	go mod init || :
	go mod tidy

	go build \
		-o "$CLANDRO_PREFIX/bin/jfrog" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded

	# Building for host to generate manpages and completion.
	chmod 700 -R $GOPATH/pkg && rm -rf $GOPATH/pkg
	unset GOOS GOARCH CGO_LDFLAGS
	unset CC CXX CFLAGS CXXFLAGS LDFLAGS
	go build \
		-o "$CLANDRO_PKG_BUILDDIR/jfrog" \
		-tags "linux extended" \
		main.go
		# "linux" tag should not be necessary
		# try removing when golang version is upgraded
}

clandro_step_make_install() {
	mkdir -p $CLANDRO_PREFIX/share/bash-completion/completions
	export JFROG_CLI_HOME_DIR=$CLANDRO_PKG_BUILDDIR/.jfrog
	mkdir -p $JFROG_CLI_HOME_DIR
	$CLANDRO_PKG_BUILDDIR/jfrog completion bash \
		> $JFROG_CLI_HOME_DIR/jfrog_bash_completion
	cp $JFROG_CLI_HOME_DIR/jfrog_bash_completion \
		$CLANDRO_PREFIX/share/bash-completion/completions/jfrog

}
