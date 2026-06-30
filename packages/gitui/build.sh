# Contributor: @PeroSar
CLANDRO_PKG_HOMEPAGE=https://github.com/gitui-org/gitui
CLANDRO_PKG_DESCRIPTION="Blazing fast terminal-ui for git written in rust"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_LICENSE_FILE="LICENSE.md"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.28.1"
CLANDRO_PKG_SRCURL=https://github.com/gitui-org/gitui/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=0400cbf59605490b5fb8779f9af41fa4d7a1bb748093ca0e13156a5dff31c7aa
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_DEPENDS="libgit2, libssh2, openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export OPENSSL_NO_VENDOR=1
	# export LIBGIT2_NO_VENDOR=1
	export LIBGIT2_SYS_USE_PKG_CONFIG=1
	export LIBSSH2_SYS_USE_PKG_CONFIG=1

	clandro_setup_cmake

	# Dummy CMake toolchain file to workaround build error:
	# error: failed to run custom build command for `libz-ng-sys v1.1.21`
	# ...
	# CMake Error at /home/builder/.termux-build/_cache/cmake-3.31.1/share/cmake-3.31/Modules/Platform/Android-Determine.cmake:218 (message):
	# Android: Neither the NDK or a standalone toolchain was found.
	export TARGET_CMAKE_TOOLCHAIN_FILE="${CLANDRO_PKG_BUILDDIR}/android.toolchain.cmake"
	touch "${CLANDRO_PKG_BUILDDIR}/android.toolchain.cmake"

	clandro_setup_rust
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"

	local f
	for f in $CARGO_HOME/registry/src/*/libgit2-sys-*/build.rs; do
		sed -i -E 's/\.range_version\(([^)]*)\.\.[^)]*\)/.atleast_version(\1)/g' "${f}"
	done
}

clandro_step_make() {
	cargo build --release \
		--jobs "$CLANDRO_PKG_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--locked
}

clandro_step_make_install() {
	install -Dm700 target/"${CARGO_TARGET_NAME}"/release/gitui "$CLANDRO_PREFIX"/bin/
}
