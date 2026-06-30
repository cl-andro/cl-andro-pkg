CLANDRO_PKG_HOMEPAGE="https://zellij.dev/"
CLANDRO_PKG_DESCRIPTION="A terminal workspace with batteries included"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="Jonathan Lei <me@xjonathan.dev>"
CLANDRO_PKG_VERSION="0.44.2"
CLANDRO_PKG_SRCURL="https://github.com/zellij-org/zellij/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz"
CLANDRO_PKG_SHA256=8a4c1558135e4dc7375fce8db3524c60289fa5eb5877068fcdeed9650140964d
CLANDRO_PKG_BUILD_DEPENDS="openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true
CLANDRO_PKG_AUTO_UPDATE=true

# wasmer doesn't support these platforms yet
CLANDRO_PKG_EXCLUDED_ARCHES="arm, i686"

clandro_step_pre_configure() {
	clandro_setup_cmake
	clandro_setup_ninja
	clandro_setup_rust

	cargo install --force --locked bindgen-cli
	export BINDGEN_EXTRA_CLANG_ARGS="--sysroot ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot"
	case "${CLANDRO_ARCH}" in
	arm) BINDGEN_EXTRA_CLANG_ARGS+=" --target=arm-linux-androideabi -isystem ${CLANDRO_STANDALONE_TOOLCHAIN}/include/c++/v1 -isystem ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot/usr/include/arm-linux-androideabi" ;;
	*) BINDGEN_EXTRA_CLANG_ARGS+=" --target=${CLANDRO_ARCH}-linux-android -isystem ${CLANDRO_STANDALONE_TOOLCHAIN}/include/c++/v1 -isystem ${CLANDRO_STANDALONE_TOOLCHAIN}/sysroot/usr/include/${CLANDRO_ARCH}-linux-android" ;;
	esac

	export OPENSSL_NO_VENDOR=1

	# aws-lc-sys
	export TARGET_CMAKE_GENERATOR=Ninja
	export ANDROID_STANDALONE_TOOLCHAIN=${CLANDRO_STANDALONE_TOOLCHAIN}
	export CFLAGS_${CARGO_TARGET_NAME//-/_}="${CFLAGS} --target=${CARGO_TARGET_NAME}${CLANDRO_PKG_API_LEVEL}"
	export CXXFLAGS_${CARGO_TARGET_NAME//-/_}="${CXXFLAGS} --target=${CARGO_TARGET_NAME}${CLANDRO_PKG_API_LEVEL}"

	# clash with rust host build
	unset CFLAGS
}

clandro_step_make() {
	cargo build --jobs ${CLANDRO_PKG_MAKE_PROCESSES} --target ${CARGO_TARGET_NAME} --release
}

clandro_step_make_install() {
	install -Dm700 -t ${CLANDRO_PREFIX}/bin target/${CARGO_TARGET_NAME}/release/zellij

	install -Dm644 /dev/null ${CLANDRO_PREFIX}/share/bash-completion/completions/zellij.bash
	install -Dm644 /dev/null ${CLANDRO_PREFIX}/share/zsh/site-functions/_zellij
	install -Dm644 /dev/null ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/zellij.fish

	unset \
		ANDROID_STANDALONE_TOOLCHAIN \
		BINDGEN_EXTRA_CLANG_ARGS \
		CFLAGS_${CARGO_TARGET_NAME//-/_} \
		CXXFLAGS_${CARGO_TARGET_NAME//-/_} \
		OPENSSL_NO_VENDOR \
		TARGET_CMAKE_GENERATOR
}

clandro_step_create_debscripts() {
	cat <<-EOF >./postinst
		#!${CLANDRO_PREFIX}/bin/sh
		zellij setup --generate-completion bash > ${CLANDRO_PREFIX}/share/bash-completion/completions/zellij.bash
		zellij setup --generate-completion zsh > ${CLANDRO_PREFIX}/share/zsh/site-functions/_zellij
		zellij setup --generate-completion fish > ${CLANDRO_PREFIX}/share/fish/vendor_completions.d/zellij.fish
	EOF
}
