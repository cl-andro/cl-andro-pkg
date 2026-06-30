CLANDRO_PKG_HOMEPAGE="https://github.com/TaKO8Ki/gobang"
CLANDRO_PKG_DESCRIPTION="A cross-platform TUI database management tool written in Rust"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.1.0-alpha.5"
CLANDRO_PKG_REVISION=4
CLANDRO_PKG_SRCURL="https://github.com/TaKO8Ki/gobang/archive/refs/tags/v$CLANDRO_PKG_VERSION.tar.gz"
CLANDRO_PKG_SHA256=923210d500f070ac862c73d1a43a10520ee8c54f6692bbce99bbd073dfa72653
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_rust

	cargo update

	if [ "$CLANDRO_ARCH" = "x86_64" ]; then
		local libdir=target/$CARGO_TARGET_NAME/release/deps
		mkdir -p $libdir
		pushd $libdir
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
		echo "INPUT(-l:libunwind.a)" > libgcc.so
		popd
	fi

	# clash with rust host build
	unset CFLAGS
}
