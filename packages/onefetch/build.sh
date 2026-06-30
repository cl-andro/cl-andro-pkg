CLANDRO_PKG_HOMEPAGE=https://onefetch.dev/
CLANDRO_PKG_DESCRIPTION="A command-line Git information tool written in Rust"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="2.27.1"
CLANDRO_PKG_SRCURL=https://github.com/o2sh/onefetch/archive/refs/tags/${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=3a6f82d3da4da62b2e5406bbe307b0afc73cd8fcc4855534886d80ea0121cc03
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_rust

	# Dummy CMake toolchain file to workaround build error:
	# error: failed to run custom build command for `libz-ng-sys v1.1.9`
	# ...
	# CMake Error at /home/builder/.termux-build/_cache/cmake-3.28.3/share/cmake-3.28/Modules/Platform/Android-Determine.cmake:217 (message):
	# Android: Neither the NDK or a standalone toolchain was found.
	export TARGET_CMAKE_TOOLCHAIN_FILE="${CLANDRO_PKG_BUILDDIR}/android.toolchain.cmake"
	touch "${CLANDRO_PKG_BUILDDIR}/android.toolchain.cmake"
}

clandro_step_make() {
	cargo build \
		--jobs $CLANDRO_PKG_MAKE_PROCESSES \
		--target $CARGO_TARGET_NAME \
		--release
}

clandro_step_make_install() {
	install -Dm700 target/"${CARGO_TARGET_NAME}"/release/onefetch "$CLANDRO_PREFIX"/bin

	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/bash-completion/completions/onefetch.bash
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/zsh/site-functions/_onefetch
	install -Dm644 /dev/null "$CLANDRO_PREFIX"/share/fish/vendor_completions.d/onefetch.fish
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		onefetch --generate bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/onefetch.bash
		onefetch --generate zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_onefetch
		onefetch --generate fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/onefetch.fish
	EOF
}
