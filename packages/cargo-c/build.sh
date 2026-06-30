CLANDRO_PKG_HOMEPAGE=https://github.com/lu-zero/cargo-c
CLANDRO_PKG_DESCRIPTION="Cargo C-ABI helpers"
CLANDRO_PKG_LICENSE="MIT"
CLANDRO_PKG_MAINTAINER="@clandro"
CLANDRO_PKG_VERSION="0.10.22"
CLANDRO_PKG_SRCURL=https://github.com/lu-zero/cargo-c/archive/refs/tags/v${CLANDRO_PKG_VERSION}.tar.gz
CLANDRO_PKG_SHA256=a7b00539437932f2a17a72b97d9c2142367a2d70ee20f9f1692a8b13c7255332
CLANDRO_PKG_AUTO_UPDATE=true
CLANDRO_PKG_UPDATE_VERSION_REGEXP='v\d+\.\d+\.\d+(?!-)'
CLANDRO_PKG_DEPENDS="libcurl, libgit2, libssh2, openssl, zlib"
CLANDRO_PKG_BUILD_IN_SRC=true

clandro_step_pre_configure() {
	export LIBGIT2_SYS_USE_PKG_CONFIG=1
	export LIBSSH2_SYS_USE_PKG_CONFIG=1

	clandro_setup_rust

	if [[ "${CLANDRO_ARCH}" == "x86_64" ]]; then
		local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
		export CARGO_TARGET_${env_host}_RUSTFLAGS+=" -C link-arg=$($CC -print-libgcc-file-name)"
	fi

	# clash with rust host build
	unset CFLAGS
}
