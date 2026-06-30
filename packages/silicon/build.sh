CLANDRO_PKG_HOMEPAGE=https://github.com/Aloxaf/silicon
CLANDRO_PKG_DESCRIPTION="Silicon is an alternative to Carbon implemented in Rust"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Yaksh Bariya <thunder-coding@termux.dev> & @clandro"
CLANDRO_PKG_VERSION="0.5.3"
CLANDRO_PKG_REVISION=1
CLANDRO_PKG_SRCURL=https://github.com/Aloxaf/silicon/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=56e7f3be4118320b64e37a174cc2294484e27b019c59908c0a96680a5ae3ad58
CLANDRO_PKG_DEPENDS="fontconfig, harfbuzz"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_rust

	# Dummy CMake toolchain file to workaround build error:
	# error: failed to run custom build command for `freetype-sys v0.13.1`
	# ...
	# CMake Error at /home/builder/.termux-build/_cache/cmake-3.27.5/share/cmake-3.27/Modules/Platform/Android-Determine.cmake:217 (message):
	# Android: Neither the NDK or a standalone toolchain was found.
	export TARGET_CMAKE_TOOLCHAIN_FILE="${CLANDRO_PKG_BUILDDIR}/android.toolchain.cmake"
	touch "${CLANDRO_PKG_BUILDDIR}/android.toolchain.cmake"
}

clandro_step_make() {
	cargo build --jobs $CLANDRO_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

clandro_step_make_install() {
	install -Dm755 -t $CLANDRO_PREFIX/bin target/${CARGO_TARGET_NAME}/release/silicon
}
