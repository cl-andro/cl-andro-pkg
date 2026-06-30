CLANDRO_PKG_HOMEPAGE=https://github.com/bettio/AtomVM
CLANDRO_PKG_DESCRIPTION="The minimal Erlang VM implementation"
CLANDRO_PKG_LICENSE="Apache-2.0"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="1:0.6.6"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/atomvm/AtomVM/archive/refs/tags/v${CLANDRO_PKG_VERSION#*:}.tar.gz
CLANDRO_PKG_SHA256=2a7de9b0ec201d992847d6ebbb444708ac07f210c9fa650d7f677c8ec20df074
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="zlib"
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DAVM_BUILD_RUNTIME_ONLY=ON
"

clandro_step_host_build() {
	clandro_setup_cmake
	cmake "$CLANDRO_PKG_SRCDIR" $CLANDRO_PKG_EXTRA_CONFIGURE_ARGS
	make -j $CLANDRO_PKG_MAKE_PROCESSES
}

clandro_step_post_configure() {
	# We need the "PackBEAM" compiled for host.
	export PATH=$PATH:$CLANDRO_PKG_HOSTBUILD_DIR/tools/packbeam
}

clandro_step_make_install() {
	install -Dm700 "$CLANDRO_PKG_BUILDDIR"/src/AtomVM \
		"$CLANDRO_PREFIX"/bin/AtomVM
	install -Dm700 "$CLANDRO_PKG_BUILDDIR"/tools/packbeam/PackBEAM \
		"$CLANDRO_PREFIX"/bin/PackBEAM
}
