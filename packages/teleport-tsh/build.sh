CLANDRO_PKG_HOMEPAGE=https://github.com/gravitational/teleport
CLANDRO_PKG_DESCRIPTION="Secure Access for Developers that doesn't get in the way"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="18.7.6"
CLANDRO_PKG_SRCURL=https://github.com/gravitational/teleport/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz
CLANDRO_PKG_SHA256=30fb59382ba7e52f799c4ac3f950b3d7a4fbdfba2a826c8789c4ec4ac8e08f8c
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_HOSTBUILD=true

clandro_step_host_build() {
	clandro_setup_golang
	pushd "$CLANDRO_PKG_SRCDIR"

	# from Makefile
	export KUBECTL_VERSION=$(go run ./build.assets/kubectl-version/main.go)
	popd
}

clandro_step_make() {
	clandro_setup_golang
	export GOPATH=$CLANDRO_PKG_CACHEDIR/go
	export BUILDDIR=$CLANDRO_PKG_SRCDIR/cmd

	make $BUILDDIR/tsh
}

clandro_step_make_install() {
	install -Dm700 -t $CLANDRO_PREFIX/bin $BUILDDIR/tsh
}
