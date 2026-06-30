CLANDRO_PKG_HOMEPAGE=https://bitcoincore.org/
CLANDRO_PKG_DESCRIPTION="Bitcoin Core"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="31.0"
CLANDRO_PKG_SRCURL="https://github.com/bitcoin/bitcoin/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=884fd15f195df3d36ab9c7d8854be16c53d9e7596ec001c283626e0fc1837e67
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="capnproto, libc++, libevent"
CLANDRO_PKG_BUILD_DEPENDS="boost-headers"
CLANDRO_PKG_SERVICE_SCRIPT=("bitcoind" 'exec bitcoind 2>&1')
CLANDRO_PKG_HOSTBUILD=true
CLANDRO_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_DAEMON=ON
-DBUILD_FUZZ_BINARY=OFF
-DBUILD_GUI=OFF
-DBUILD_TESTS=OFF
-DBUILD_TX=ON
-DBUILD_UTIL=ON
-DBUILD_WALLET_TOOL=ON
"

clandro_step_host_build() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_capnp

	cmake "$CLANDRO_PKG_SRCDIR/src/ipc/libmultiprocess" -GNinja
	ninja -j "$CLANDRO_PKG_MAKE_PROCESSES"
}

_setup_mpgen() {
	if [[ "$CLANDRO_ON_DEVICE_BUILD" == "true" ]]; then
		return
	fi

	export PATH="$CLANDRO_PKG_HOSTBUILD_DIR:$PATH"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DMPGEN_EXECUTABLE=$(command -v mpgen)"
}

clandro_step_pre_configure() {
	clandro_setup_capnp
	_setup_mpgen

	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCAPNP_EXECUTABLE=$(command -v capnp)"
	CLANDRO_PKG_EXTRA_CONFIGURE_ARGS+=" -DCAPNPC_CXX_EXECUTABLE=$(command -v capnpc-c++)"
}
